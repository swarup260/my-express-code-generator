---
to: <%= path %>/config.js
---

module.exports = {
    PORT : 3000 || process.env.PORT,
    MONGODB_URI: "mongodb://mongo:27017/TodoAppV2?retryWrites=true",
    MONGODB_PORT : "27017",
<% if(authentication == 'JWT') { -%>
    JWT_SECRET_PK: "JWT_SECRET",
    JWT_SECRET_PUK: "JWT_SECRET",
<% } -%>
<% if(authentication != 'JWT') { -%>
    JWT_SECRET_PK: fs.readFileSync('privatekey.pem', 'utf8'),
    JWT_SECRET_PUK: fs.readFileSync('publickey.pem', 'utf8'),
<% } -%>
    JWT_EXPIRES : 60*60,
    SALT_ROUNDS : 10
}