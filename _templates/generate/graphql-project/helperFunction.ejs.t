---
to: <%= path %>/src/lib/helperFunctions.js
---
const crypto = require('crypto')
const { promisify } = require('util')
const scrypt = promisify(crypto.scrypt)
const jsonwebtoken = require('jsonwebtoken')
const fs = require('fs/promises')
const userModel = require('../models/users.model')



async function encryptPassword(password) {
    const salt = crypto.randomBytes(16).toString('hex')
    const encryptPass = await scrypt(password, salt, 64);
    return `${encryptPass.toString('hex')}:${salt}`.toString()
}

async function decryptPassword(password, encryptPassword) {
    const [encryptPass, salt] = encryptPassword.split(':')
    const calculateEncryptPass = await scrypt(password, salt, 64);
    const keyBuffer = Buffer.from(encryptPass, 'hex')
    if (crypto.timingSafeEqual(keyBuffer, calculateEncryptPass)) {
        return true
    }
    return false
}

async function getToken(data) {
    return jsonwebtoken.sign(data,await getPrivateKey())
}

async function verifyToken(token) {
    return jsonwebtoken.verify(token,await getPublicKey())
}

async function getPrivateKey() {
    return await fs.readFile('./privatekey.pem', 'utf-8')
}

async function getPublicKey() {
    return await fs.readFile('./publickey.pem', 'utf-8')
}

async function userExists({email}) {
    const result = userModel.getUser({email})
    return result
}

module.exports = {
    encryptPassword,
    decryptPassword,
    getToken,
    verifyToken,
    userExists
}