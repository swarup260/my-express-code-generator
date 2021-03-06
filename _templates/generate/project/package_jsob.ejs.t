---
to: <%= path %>/package.json
---

{
  "name": "<%= projectName %>",
  "version": "1.0.0",
  "description": "<%= projectDescription %>",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "bcrypt": "^4.0.1",
    "body-parser": "^1.19.0",
    "cors": "^2.8.5",
    "express": "^4.17.1",
    "jsonwebtoken": "^8.5.1",
    "moment": "^2.29.1",
    "mongoose": "^5.9.7"
  },
  "devDependencies": {
    "nodemon": "^2.0.2"
  }
}