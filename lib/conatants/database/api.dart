import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(uri: 'https://countries.trevorblades.com/graphql'),
  ),
);

final String getContinentsQuery = """
query{
  continents{
    code
    name
  }
}
""";

String getContinentQuery(String code) => """
query{
  continent(code:"$code"){
    name
    countries{
      name
      native
      phone
      capital
      currency
      emoji
      languages{
        name
        native
      }
    }
  }
}
""";
