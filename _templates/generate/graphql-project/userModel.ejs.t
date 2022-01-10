---
to: <%= path %>/src/models/users.model.js
---
const db = require('../lib/db')
const DatabaseError = require('../errors/database.error')

class UserModel {
    
    constructor(){
        this.TABLE_NAME = 'users'
    }

    async createUser(newObject){
        const result  = await db(this.TABLE_NAME).returning('id').insert(newObject)
        if (result) {
            return result
        }

        throw new DatabaseError(1234,'Fail Insert new user')

    }

    async getUser(condition){
        const result = await  db(this.TABLE_NAME).where(condition)
        if (result.length == 0) {
            throw new DatabaseError(1234,'Fail User not found')
        }
        return result[0]
    }

    async getUsers(condition,limit){
        const result = await  db(this.TABLE_NAME).where(condition).limit(limit)
        if (result.length == 0) {
            return []
        }
        return result
    }

    async updateUser({
        condition,
        update
    }){
        const result = await db(this.TABLE_NAME).where(condition).update(update)
        if (result) {
            return true
        }
        throw new DatabaseError(1234,'Fail Update')

    }

    async deleteUser({
        condition
    }){
        const result = await db(this.TABLE_NAME).where(condition).del()
        if (result) {
            return true
        }
        throw new DatabaseError(1234,'Fail delete')
    }
}

module.exports = new UserModel()