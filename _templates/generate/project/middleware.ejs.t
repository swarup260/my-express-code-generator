---
to: <%= path %>/app/middleware/checkAuth.middleware.js
---

const jwt = require('jsonwebtoken');
const config = require('../config');
const {
    userExists
} = require('../utils/util');

module.exports = async (request, response, next) => {
    try {
        const token = await request.headers.authorization.split(" ")[1];
        const publicKey = await config.JWT_SECRET_PUK()
        const decoded = jwt.verify(token, publicKey);
        const user = await userExists(decoded);
        request.userData = user;
        next();
    } catch (error) {
        return response.status(401).json({
            status: false,
            message: 'Unauthorised Access'
        });
    }

}