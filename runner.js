// const { runner } = require('hygen')
// const Logger = require('hygen/lib/logger')
// const path = require('path')
// const chalk = require('chalk')
// const defaultTemplates = path.join(__dirname, '_templates')

// if (process.argv.slice(2).length === 0) {
//   console.log(chalk.green(`

//   /* ---------------------------------------------------------- */
//   /*     GENERATE NEW PROJECT SCAFFOLD                          */
//   /* ---------------------------------------------------------- */

//   npm start start projectGenerator new
//   `));

//   console.log(chalk.green(`

//   /* ---------------------------------------------------------- */
//   /*     GENERATE NEW CONTROLLER SCAFFOLD                       */
//   /* ---------------------------------------------------------- */

//   npm start start projectGenerator controller
//   `))
//   // Exit
//   // return
// }

// runner(process.argv.slice(2), {
//   templates: defaultTemplates,
//   cwd: process.cwd(),
//   logger: new Logger(console.log.bind(console)),
//   createPrompter: () => require('enquirer'),
//   exec: (action, body) => {
//     const opts = body && body.length > 0 ? { input: body } : {}
//     return require('execa').shell(action, opts)
//   },
//   debug: !!process.env.DEBUG
// })
const path = require('path')
const defaultTemplates = path.join(__dirname, '_templates')
const ncp = require('ncp')
const { promisify } = require('util')
const copy = promisify(ncp.ncp)

const copyFile = async () => await copy(`${defaultTemplates}/generate/dockerTemplates`, 'out', {
  clobber: false
})

copyFile()
  .then(val => console.log(val))
  .catch(err => console.error(err))

console.log(`${defaultTemplates}\\dockerTemplates`, process.cwd())
