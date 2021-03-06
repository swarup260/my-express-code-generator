---
to: <%= path %>/src/errors/validation.error.js
---
module.exports = class ValidationError extends Error {
    constructor(code, ...params) {
        // Pass remaining arguments (including vendor specific ones) to parent constructor
        super(...params)
        // Maintains proper stack trace for where our error was thrown (only available on V8)
        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, ValidationError)
        }
        this.name = 'Validation Error'
        this.code = code
    }
}