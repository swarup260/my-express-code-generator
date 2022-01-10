---
to: <%= path %>/package.json
---
{
  "name": "<%= projectName %>",
  "version": "1.0.0",
  "description": "<%= projectDescription %>",
  "main": "index.js",
  "scripts": {
    "start": "node app.js",
    "dev": "nodemon -L app.js",
    "lint": "eslint --fix-dry-run .",
    "db:migrate": "npx knex migrate:latest",
    "db:migrate:production": "npx knex migrate:latest --env production",
    "db:rollback": "npx knex migrate:rollback",
    "db:rollback:all": "npx knex migrate:rollback --all"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@graphql-tools/load-files": "^6.5.2",
    "apollo-server": "^3.6.1",
    "dotenv": "^10.0.0",
    "graphql": "^15.8.0",
    "graphql-tools": "^8.2.0",
    "jsonwebtoken": "^8.5.1",
    "knex": "^0.95.14",
    "mysql": "^2.18.1"
  },
  "devDependencies": {
    "eslint": "^8.4.1",
    "nodemon": "^2.0.15"
  }
}
