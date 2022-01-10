---
to: <%= path %>/src/controllers/<%= name %>.controller.js
---
const <%= name %>Model = require('../models/<%= name %>.model')
const ValidationError = require('../errors/validation.error')

class <%= h.capitalize(name) %>Controller {

    async add<%= h.capitalize(name) %>(_, { input }) {
        try {
            //validation check

            const result = await <%= name %>Model.create<%= h.capitalize(name) %>(input)

            return {
                code: 1000,
                success: true,
                message: "Success",
                id: result
            }
        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }

        }
    }

    async update<%= h.capitalize(name) %>(_, { id, fields }) {
        try {

            if (!fields.<%= name %>_name || !fields.<%= name %>_status) {
                throw new ValidationError("required fields missing")
            }

            const result = await <%= name %>Model.update<%= h.capitalize(name) %>({
                condition: { id },
                update: fields
            })

            return {
                code: 1000,
                success: true,
                message: "Success",
                id: result
            }

        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }
        }
    }

    async delete<%= h.capitalize(name) %>(_, { id }) {
        try {
            const result = await <%= name %>Model.delete<%= h.capitalize(name) %>({ id })

            return {
                code: 1000,
                success: true,
                message: "Success",
                id: result
            }

        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }
        }
    }

    async get<%= h.capitalize(name) %>(_, { id }) {
        try {

            return {
                code: 1000,
                success: true,
                message: "Success",
                country: await <%= name %>Model.get<%= h.capitalize(name) %>({ id })
            }
        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }
        }
    }

    async get<%= h.capitalize(name) %>s(_, { limit, offset }) {
        try {
            return {
                code: 1000,
                success: true,
                message: "Success",
                <%= name %>s: await <%= name %>Model.get<%= h.capitalize(name) %>s({ limit, offset }),
                pageInfo: { totalCount : await <%= name %>Model.get<%= h.capitalize(name) %>sCount({ limit, offset }) }
            }
        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }
        }
    }

    async search<%= h.capitalize(name) %>s(_, { fields, limit, offset }) {
        try {

            const condition = {}

            return {
                code: 1000,
                success: true,
                message: "Success",
                <%= name %>s: await <%= name %>Model.get<%= h.capitalize(name) %>s({ condition, limit, offset }),
                pageInfo: { totalCount: await <%= name %>Model.get<%= h.capitalize(name) %>sCount({ condition }) }
            }
        } catch (error) {
            return {
                code: error.code || 1001,
                success: false,
                message: error.message
            }
        }
    }
}

module.exports = new <%= h.capitalize(name) %>Controller()
