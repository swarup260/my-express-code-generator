// my-generator/my-action/index.js
module.exports = {
   prompt: ({ inquirer }) => {
      const questions = [{
         type: 'input',
         name: 'projectName',
         message: "project name ?"
      },
      {
         type: 'input',
         name: 'projectDescription',
         message: "project description ?"
      },
      {
         type: 'select',
         name: 'authentication',
         message: "Authentication  type ?",
         choices: ["JWT", "JWT-RSA", "JWT-ECDSA"]
      },
      {
         type: 'confirm',
         name: 'path',
         initial: '.',
         message: "use current directory ?"
      }]

      return inquirer
         .prompt(questions)
         .then(answers => {
            const { path } = answers
            const questions = []
            if (path === false) {
               questions.push({
                  type: 'input',
                  name: 'path',
                  message: "specify the directory ?"
               })
            }

            return inquirer
               .prompt(questions)
               .then(nextAnswers => Object.assign({}, answers, nextAnswers))
         })
   },
}
