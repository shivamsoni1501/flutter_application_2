import 'package:flutter/material.dart';
import 'package:flutter_application_2/conatants/constants.dart';
import 'package:flutter_application_2/conatants/database/api.dart';
import 'package:flutter_application_2/screens/continent.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Continents extends StatelessWidget {
  const Continents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("CONTINENTS"),
      backgroundColor: ColorP[4],
      body: Center(
        child: Query(
          //to interact with graphql database
          options: QueryOptions(documentNode: gql(getContinentsQuery)),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            } else if (result.loading) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorP[2]),
              );
            } else {
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Continent(
                            data: result.data['continents'][index],
                          ),
                        ),
                      );
                    },
                    child: ContinentTile(
                      name: result.data['continents'][index]['name'],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ContinentTile extends StatelessWidget {
  final String name;
  const ContinentTile({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorP[3],
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Hero(
          tag: name,
          child: Text(
            name,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
                color: ColorP[1]),
          ),
        ),
      ),
    );
  }
}
