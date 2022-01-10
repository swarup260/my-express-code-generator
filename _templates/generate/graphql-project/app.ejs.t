---
to: <%= path %>/index.js
---
// dependencies
const { ApolloServer } = require('apollo-server');
const typeDefs = require('./src/models/typeDefs')
const resolvers = require('./src/resolvers')

// server configuration 
const PORT = process.env.PORT || 3000

const options = {
  port : PORT
}

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context({ req }){
    const token = req.headers.authorization
    return {
      token
    }
  }
})

/* SERVER STARTING */
server.listen(options).then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});

