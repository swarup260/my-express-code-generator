---
to: <%= path %>/src/errors/database.error.js
---
module.exports = class DatabaseError extends Error {
    constructor(code, ...params) {
        // Pass remaining arguments (including vendor specific ones) to parent constructor
        super(...params)
        // Maintains proper stack trace for where our error was thrown (only available on V8)
        if (Error.captureStackTrace) {
            Error.captureStackTrace(this, DatabaseError)
        }
        this.name = 'Database Error'
        this.code = code
    }
}