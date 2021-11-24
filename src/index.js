import { Command } from 'commander/esm.mjs'
import inquirer from 'inquirer'
import Listr from 'listr'
import boxen from 'boxen'
import chalk from 'chalk'
import { buildTemplate, gitInit, installPackage, generateJWTKeys, setupDocker } from './processes'

/**
 *
 * @param {Object} rawArgs
 * @returns Object
 */
function parseArgumentsIntoOptions (rawArgs) {
  const program = new Command()
  program
    .description('scaffold project/controller for existing project')
    .option('-p, --project-name <value>', 'project name')
    .option('-c, --controller-name <value>', 'controller name')
    .option('-g,--git', 'git init', false)
    .option('-i,--install', 'npm package installation', false)
    .version('0.0.1', '-v, --version', 'output the current version')

  program.parse(rawArgs)

  return program.opts()
}

/**
 *
 * @param {Object} rawArgs
 * @returns Object
 */
async function promptForMissingOptions (rawArgs) {
  const questions = [
    {
      type: 'list',
      name: 'authentication',
      message: 'Authentication  type ?',
      choices: ['JWT', 'JWT-RSA', 'JWT-ECDSA'],
      default: 'JWT'
    },
    {
      type: 'confirm',
      name: 'docker',
      message: 'setup docker ?'
    }
  ]
  if (rawArgs.projectName) {
    questions.unshift({
      type: 'input',
      name: 'projectDescription',
      message: 'project description ?'
    })
  }

  const options = await inquirer.prompt(questions)

  return {
    ...rawArgs,
    ...options,
    path: process.cwd()
  }
}

/**
 *
 * @param {Object} rawArgs
 * @returns Array
 */
function parseProjectTemplateOptions (rawArgs) {
  if (!rawArgs.projectName) {
    throw new Error('project name undefined')
  }
  return [
    'generate', 'project',
    '--projectName', rawArgs.projectName,
    '--projectDescription', rawArgs.projectDescription,
    '--path', rawArgs.path,
    '--authentication', rawArgs.authentication
  ]
}

/**
 *
 * @param {Object} rawArgs
 * @returns Array
 */
function parseControllerTemplateOptions (rawArgs) {
  if (!rawArgs.projectName) {
    throw new Error('controller name undefined')
  }
  return [
    'generate', 'controller',
    '--name', rawArgs.controllerName,
    '--path', rawArgs.path
  ]
}

/**
 *
 * @param {Object} options
 *
 */
async function taskRunner (options) {
  const tasks = new Listr([
    {
      title: 'Project Templates Generating',
      task: async () => await buildTemplate(parseProjectTemplateOptions(options)),
      skip: () => options.projectName === undefined
    },
    {
      title: 'Controller Templates Generating',
      task: async () => await buildTemplate(parseControllerTemplateOptions(options)),
      skip: () => options.controllerName === undefined
    },
    {
      title: 'JWT Token Generating',
      skip: () => options.authentication === 'JWT',
      task: async () => await generateJWTKeys(options)
    },
    {
      title: 'Git Initailization',
      task: async () => await gitInit(),
      enabled: () => options.git
    },
    {
      title: 'Docker Setup',
      skip: () => options.docker === false,
      task: async () => await setupDocker(options)
    },
    {
      title: 'Package Installation',
      task: async () => await installPackage({
        cwd: process.cwd()
      }),
      skip: () =>
        !options.install
          ? 'Pass --install to automatically install dependencies'
          : undefined
    }
  ])

  await tasks.run()
  console.log(boxen(chalk.green('npm run dev'), { padding: 1, margin: 1, borderStyle: 'double' }))
}

/**
 *
 * @param {Object*} options
 */
export async function cli (options) {
  const parseOptions = parseArgumentsIntoOptions(options)
  const promptgOptions = await promptForMissingOptions(parseOptions)
  console.log(promptgOptions)
  await taskRunner({ ...parseOptions, ...promptgOptions })
}
