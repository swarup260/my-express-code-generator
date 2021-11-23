import { runner, Logger } from "hygen";
import path from "path";
import { projectInstall } from "pkg-install";
import crypto from "crypto";
import { promisify } from "util";
import fs from "fs";
import { config } from "process";

const generateKeyPair = promisify(crypto.generateKeyPair)
const writeFile = promisify(fs.writeFile)

const defaultTemplates = path.join(__dirname, '..\\_templates')


/**
 * 
 * @param {Object} rawArgs 
 */
async function buildTemplate(rawArgs) {
    await runner(rawArgs, {
        templates: defaultTemplates,
        cwd: process.cwd(),
        logger: new Logger(console.log.bind(console)),
        createPrompter: () => { },
        exec: (action, body) => {
            const opts = body && body.length > 0 ? { input: body } : {}
            return require('execa').shell(action, opts)
        },
        debug: !!process.env.DEBUG
    })

}

/**
 * 
 * @param {Object} rawArgs 
 */
async function gitInit(rawArgs) {
}

/**
 * 
 * @param {Object} rawArgs 
 */
async function generateJWTKeys(rawArgs) {
    try {

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
        if (rawArgs.authentication === "JWT-ECDSA") {
            CONFIG['namedCurve'] = 'sect239k1'
        }

        const AUTH_TYPE = rawArgs.authentication === "JWT-ECDSA" ? "ec" : "rsa"

        const {
            publicKey,
            privateKey,
        } = await generateKeyPair(AUTH_TYPE, CONFIG);

        await writeFile(`${rawArgs.path}/privateKey.pem`, privateKey)
        await writeFile(`${rawArgs.path}/publicKey.pem`, publicKey)
    } catch (error) {
        throw error
    }



}

/**
 * 
 * @param {Object} rawArgs 
 */
async function setupDocker(rawArgs) {

}

/**
 * 
 * @param {Object} rawArgs 
 */
async function installPackage(rawArgs) {
    await projectInstall(rawArgs)
}



export {
    buildTemplate,
    gitInit,
    generateJWTKeys,
    installPackage,
    setupDocker
}