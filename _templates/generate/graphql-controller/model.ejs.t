---
to: <%= path %>/src/models/<%= name %>.model.js
---

const db = require('../utils/db')
const DatabaseError = require('../errors/database.error')

class <%= h.capitalize(name) %>Model {

    constructor() {
        this.TABLE_NAME = 'ad_<%= name %>'
        this.LIMIT = 10
        this.OFFSET = 0
    }

    async create<%= h.capitalize(name) %>(newObject) {
        const result = await db(this.TABLE_NAME).returning('id').insert(newObject)
        if (result) {
            return result[0]
        }

        throw new DatabaseError(1234, 'Fail to Insert new <%= h.capitalize(name) %>')

    }

    async update<%= h.capitalize(name) %>({
        condition,
        update
    }) {
        const result = await db(this.TABLE_NAME).where(condition).update(update).returning('id')
        if (result) {
            return result[0]
        }
        throw new DatabaseError(1234, 'Fail to Update <%= h.capitalize(name) %>')

    }

    async delete<%= h.capitalize(name) %>({
        condition
    }) {
        const result = await db(this.TABLE_NAME).where(condition).del().returning('id')
        if (result) {
            return result[0]
        }
        throw new DatabaseError(1234, 'Fail to Delete <%= h.capitalize(name) %>')
    }

    async get<%= h.capitalize(name) %>(condition) {
        const result = await db(this.TABLE_NAME).where(condition)
        if (result.length == 0) {
            return {}
        }
        return result[0]
    }

    async get<%= h.capitalize(name) %>s({condition, limit, offset}) {
        const builderQuery = db(this.TABLE_NAME)
            .limit(limit || this.LIMIT)
            .offset(offset || this.OFFSET)

        if (condition) {
            builderQuery.where(condition)
        }

        const result = await builderQuery
        if (result.length == 0) {
            return []
        }
        return result
    }

    async get<%= h.capitalize(name) %>sCount({ condition }) {
        const builderQuery = db(this.TABLE_NAME)

        if (condition) {
            builderQuery.where(condition)
        }

        const result = await builderQuery.count('id_country', { as: 'counts' })
        if (result.length == 0) {
            return 0
        }
        return result[0].counts
    }

}


module.exports = new <%= h.capitalize(name) %>Model()