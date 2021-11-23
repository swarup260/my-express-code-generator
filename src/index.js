import { Command } from 'commander/esm.mjs';
import inquirer from 'inquirer';
import Listr from 'listr';
import boxen from 'boxen';
import chalk from 'chalk'
import { buildTemplate } from './processes'
import path from 'path'

function parseArgumentsIntoOptions(rawArgs) {
    const program = new Command();
    program
        .option('-p, --project-name', 'project name')
        .option('-v,--version', '0.1.0');

    program.parse(rawArgs);

    return program.opts()
}

async function promptForMissingOptions(rawArgs) {
    let questions = [
        {
            type: 'input',
            name: 'first_name',
            message: "What's your first name",
        }
    ]

    return await inquirer.prompt(questions);

}

async function taskRunner(options) {
    const fullPathName = new URL(import.meta.url).pathname;
    const templateDir = path.resolve(
      fullPathName.substr(fullPathName.indexOf('/')),
      '../../templates',
      ''
    );
    console.log(templateDir);
    const tasks = new Listr([
        // {
        //     title: 'Templates Generating',
        //     task: () => buildTemplate(['generate', 'controller', '--name', 'user', '--path'])
        // },
        {
            title: 'JWT Token Generating',
            skip: () => options.jwtType != 'secret',
            task: () => 'Success'
        },
        {
            title: 'Git Initailization',
            task: () => 'Failure'
        },
        {
            title: 'Package Installation',
            task: () => 'Failure'
        },
    ]);

    await tasks.run()
    console.log(boxen(chalk.green('npm run dev'), { padding: 1, margin: 1, borderStyle: 'double' }));
}

export async function cli(options) {
    let parseOptions = parseArgumentsIntoOptions(options)
    let promptgOptions = await promptForMissingOptions(options)
    console.log({ ...parseOptions, ...promptgOptions })
    await taskRunner({ ...parseOptions, ...promptgOptions })
}