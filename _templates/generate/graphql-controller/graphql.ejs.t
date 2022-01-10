---
to: <%= path %>/src/typeDefs/<%= name %>.typedefs.graphql
---

interface Response {
  code: String!
  success: Boolean!
  message: String!
}

input <%= h.capitalize(name) %>Input {

}

type PageInfo {
  totalCount:Int!
}

type MutationResponse implements Response {
  code: String!
  success: Boolean!
  message: String!
  id_country:ID
}

type Query {
  get<%= h.capitalize(name) %>() : Response
  get<%= h.capitalize(name) %>s() : Response
  search<%= h.capitalize(name) %>() : Response
}

type Mutation  {
  add<%= h.capitalize(name) %>() : MutationResponse
  update<%= h.capitalize(name) %>() : MutationResponse
  delete<%= h.capitalize(name) %>() : MutationResponse
}