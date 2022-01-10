---
to: <%= path %>/src/controllers/users.controller.js
---
const userModel = require('../models/users.model')
const { encryptPassword, decryptPassword, getToken } = require('../lib/helperFunctions')
const ValidationError = require('../errors/validation.error')
const ApplicationError = require('../errors/application.error')

class UserController {

    async getUser(_, { email }) {
        try {
            return await userModel.getUser({ email })
        } catch (error) {
            throw new ApplicationError(error)
        }
    }

    async register(_, { name, email, password,username }) {
        try {

            // encrypt password 
            password = await encryptPassword(password)

            const result = await userModel.createUser({
                name,
                email,
                password,
                username
            })
            const token = getToken({ email: result.email })

            return {
                ...result,
                token
            }

        } catch (error) {
            throw new ApplicationError(error)
        }
    }

    async login(_, { email, password }) {
        try {
            const result = await userModel.getUser({ email: email })

            if (!await decryptPassword(password, result.password)) {
                throw new ValidationError(1224, 'Fail Incorrect Password')
            }

            const token = getToken({ email: result.email })

            return {
                ...result,
                token
            }


        } catch (error) {
            throw new ApplicationError(error)
        }
    }

}

module.exports = new UserController()