---
to: <%= path %>/src/middlewares/checkauth.middleware.js
---
const AuthenticationError = require("../errors/authentication.error");
const { verifyToken,userExists } = require('../lib/helperFunctions')

// eslint-disable-next-line no-unused-vars
module.exports = async (authorization) => {
    try {
        const token =  authorization.split(" ")[1]
        const decoded = verifyToken(token);
        return await userExists(decoded);
    } catch (error) {
        throw new AuthenticationError(1235,'Fail Unauthorised Access')
    }

}