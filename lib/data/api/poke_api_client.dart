import 'package:flutter/material.dart';
import 'package:flutter_dex/data/api/http_client_logger.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class PokeApiClient {
  final ValueNotifier<GraphQLClient> client;

  PokeApiClient(String baseUrl)
      : client = ValueNotifier(
          GraphQLClient(
              cache: GraphQLCache(),
              link: HttpLink(baseUrl,
                  httpClient: HttpClientLogger(http.Client()))),
        );

  Future<QueryResult> query(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    final QueryResult result = await client.value.query(QueryOptions(
      document: gql(query),
      variables: variables,
    ));

    if (result.exception != null) {
      print(result.exception);
      for (final GraphQLError error in result.exception!.graphqlErrors) {
        print(error.message);
      }
    }

    return result;
  }
}
