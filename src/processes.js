import { runner, Logger } from 'hygen'
import path from 'path'
import { projectInstall } from 'pkg-install'
import crypto from 'crypto'
import { promisify } from 'util'
import fs from 'fs'
import execa from 'execa'
import gitignore from 'gitignore'
import ncp from 'ncp'

const copy = promisify(ncp.ncp)
const writeGitignore = promisify(gitignore.writeFile)
const generateKeyPair = promisify(crypto.generateKeyPair)
const writeFile = promisify(fs.writeFile)

const defaultTemplates = path.join(__dirname, '..\\_templates')

/**
 *
 * @param {Object} options
 */
async function buildTemplate (options) {
  await runner(options, {
    templates: defaultTemplates,
    cwd: process.cwd(),
    logger: new Logger(console.log.bind(console)),
    createPrompter: () => { },
    exec: (action, body) => {
      const opts = body && body.length > 0 ? { input: body } : {}
      //   return execa.shell(action, opts)
      return execa.command(action, opts)
    },
    debug: !!process.env.DEBUG
  })
}

/**
 *
 * @param {Object} options
 */
async function gitInit (options) {
  const result = await execa('git', ['init'], {
    cwd: options.path
  })
  if (result.failed) {
    return Promise.reject(new Error('Failed to initialize git'))
  }
  createGitignore(options)
//   console.log('helo')
}

async function createGitignore (options) {
  const file = fs.createWriteStream(
    path.join(options.path, '.gitignore'),
    { flags: 'a' }
  )
  return writeGitignore({
    type: 'Node',
    file: file
  })
}

/**
 *
 * @param {Object} options
 */
async function generateJWTKeys (options) {
  const CONFIG = {
    modulusLength: 4096,
    publicKeyEncoding: {
      type: 'spki',
      format: 'pem'
    },
    privateKeyEncoding: {
      type: 'pkcs8',
      format: 'pem'
    }
  }
  if (options.authentication === 'JWT-ECDSA') {
    CONFIG.namedCurve = 'sect239k1'
  }

  const AUTH_TYPE = options.authentication === 'JWT-ECDSA' ? 'ec' : 'rsa'

  // eslint-disable-next-line no-useless-catch
  try {
    const {
      publicKey,
      privateKey
    } = await generateKeyPair(AUTH_TYPE, CONFIG)

    await writeFile(`${options.path}/privateKey.pem`, privateKey)
    await writeFile(`${options.path}/publicKey.pem`, publicKey)
  } catch (error) {
    return Promise.reject(new Error('Failed to generate JWTKeys'))
  }
}

/**
 *
 * @param {Object} options
 */
async function setupDocker (options) {
  await copy(`${defaultTemplates}/generate/dockerTemplates`, options.path, {
    clobber: false
  })
}

/**
 *
 * @param {Object} options
 */
async function installPackage (options) {
  await projectInstall(options)
}

export {
  buildTemplate,
  gitInit,
  generateJWTKeys,
  installPackage,
  setupDocker
}
