import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static final HttpLink httpLink =
      HttpLink(
        uri: 'https://api.reportresults.gia.edu', 
        headers: {"authorization" : "81323e54-3793-47ce-a2b6-cba1ba5d4fcb"}
      );

  // static final AuthLink authLink = AuthLink(
  //   //getToken: () => '81323e54-3793-47ce-a2b6-cba1ba5d4fcb',
  //   getToken: () => '36965900-7504-4e64-ba0b-263f66e4fd64',
  // );

  //static final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
