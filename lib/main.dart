import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/continents.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'conatants/database/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Continents Demo',
        debugShowCheckedModeBanner: false,
        home: Continents(),
      ),
    );
  }
}
