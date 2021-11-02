import { Command } from 'commander/esm.mjs';
const program = new Command();



function parseArgumentsIntoOptions(rawArgs) {
    program
        .option('-d, --debug', 'output extra debugging')
        .option('-s, --small', 'small pizza size')
        .option('-p, --pizza-type <type>', 'flavour of pizza');

    program.parse(rawArgs);

    return program.opts()
}

export function cli(options) {
    let parseOptions = parseArgumentsIntoOptions(options)
    console.log(parseOptions)
}