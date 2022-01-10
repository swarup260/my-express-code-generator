---
to: <%= path %>/src/errors/authentication.error.js
---
module.exports = class AuthenticationError extends Error {
    constructor(code, ...params) {
        // Pass remaining arguments (including vendor specific ones) to parent constructor
        super(...params)
        // Maintains proper stack trace for where our error was thrown (only available on V8)
        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, AuthenticationError)
        }
        this.name = 'Authentication Error'
        this.code = code
    }
}