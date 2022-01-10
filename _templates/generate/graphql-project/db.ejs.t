---
to: <%= path %>/src/lib/db.js
---
const knex = require('knex')
const knexfile = require('../knexfile')
const db = knex(process.env.IS_PRODUCTION == 1 ? knexfile.production : knexfile.development)

module.exports = db
