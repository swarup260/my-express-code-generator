import { Command } from 'commander/esm.mjs';
import inquirer from 'inquirer';
import Listr from 'listr';
import ora from 'ora';

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

    const spinner = ora('').start();

    const tasks = new Listr([
        {
            title: 'Success',
            task: () => {
                setTimeout(() => {
                    spinner.color = 'yellow';
                    spinner.stop()
                }, 1000);

            }
        },
        {
            title: 'Failure',
            task: () => 'Failure'
        }
    ]);

    return await tasks.run()
}
export async function cli(options) {
    let parseOptions = parseArgumentsIntoOptions(options)
    let promptgOptions = await promptForMissingOptions(options)
    console.log({ ...parseOptions, ...promptgOptions })
    taskRunner({ ...parseOptions, ...promptgOptions })

}