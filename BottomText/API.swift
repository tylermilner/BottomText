//  This file was automatically generated and should not be edited.

import Apollo

public final class AllPostsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllPosts {" +
    "  allPosts {" +
    "    __typename" +
    "    id" +
    "    body" +
    "    createdAt" +
    "    author {" +
    "      __typename" +
    "      id" +
    "      name" +
    "    }" +
    "  }" +
    "}"
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let allPosts: [AllPost]

    public init(reader: GraphQLResultReader) throws {
      allPosts = try reader.list(for: Field(responseName: "allPosts"))
    }

    public struct AllPost: GraphQLMappable {
      public let __typename: String
      public let id: GraphQLID
      public let body: String
      public let createdAt: String?
      public let author: Author?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        id = try reader.value(for: Field(responseName: "id"))
        body = try reader.value(for: Field(responseName: "body"))
        createdAt = try reader.optionalValue(for: Field(responseName: "createdAt"))
        author = try reader.optionalValue(for: Field(responseName: "author"))
      }

      public struct Author: GraphQLMappable {
        public let __typename: String
        public let id: GraphQLID
        public let name: String

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          id = try reader.value(for: Field(responseName: "id"))
          name = try reader.value(for: Field(responseName: "name"))
        }
      }
    }
  }
}