---
to: <%= path %>/config.js
---
<% if(authentication != 'JWT') { -%>
const fs = require('fs/promises')
<% } -%>
module.exports = {
    PORT : 3000 || process.env.PORT,
    MONGODB_URI: "mongodb://mongo:27017/<%= name %>?retryWrites=true",
    MONGODB_PORT : "27017",
<% if(authentication == 'JWT') { -%>
    JWT_SECRET_PK: "JWT_SECRET",
    JWT_SECRET_PUK: "JWT_SECRET",
<% } -%>
<% if(authentication != 'JWT') { -%>
    JWT_SECRET_PK: async () => await fs.readFile('./privatekey.pem', 'utf-8'),
    JWT_SECRET_PUK: async () => await fs.readFile('./publickey.pem', 'utf-8'),
<% } -%>
    JWT_EXPIRES : 60*60,
    SALT_ROUNDS : 10
}