---
to: <%= path %>/src/typeDefs/users.typedefs.graphql
---
type User {
  id:Int
  name:String
  email:String
  username:String
  token:String
}

type Query {
  getUser(email:String!): User
}

type Mutation  {
  register(
    name: String!
    email: String!
    username: String!
    password: String!
  ): User

  login(
    email: String!
    password: String!
  ): User
}
