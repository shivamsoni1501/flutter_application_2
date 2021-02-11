import 'package:flutter/material.dart';
import 'package:flutter_application_2/conatants/constants.dart';
import 'package:flutter_application_2/conatants/database/api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Continent extends StatelessWidget {
  final dynamic data;
  const Continent({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(data['name']),
      backgroundColor: ColorP[4],
      body: Center(
        child: Query(
          options: QueryOptions(
              documentNode: gql(getContinentQuery(this.data['code']))),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            } else if (result.loading) {
              return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ColorP[2]));
            } else {
              List<dynamic> temp = result.data['continent']['countries'];
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: temp.length,
                itemBuilder: (BuildContext context, int index) {
                  return CountryTile(data: temp[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CountryTile extends StatefulWidget {
  final dynamic data;
  const CountryTile({Key key, this.data}) : super(key: key);

  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  bool _toggleS = false;

  _toggle() {
    _toggleS = !_toggleS;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Card(
          color: ColorP[3],
          elevation: 10,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            curve: Curves.easeIn,
            height: _toggleS ? 280 : 100,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        minRadius: 30,
                        backgroundColor: ColorP[4],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data['emoji'],
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: ColorP[0],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data['name'],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(shadows: [
                                Shadow(
                                    color: ColorP[4],
                                    blurRadius: 2,
                                    offset: Offset(3, -2))
                              ], fontSize: 25, color: ColorP[1]),
                            ),
                            Text(
                              widget.data['native'],
                              style: TextStyle(
                                  color: ColorP[4],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // if (_toggleS)
                Flexible(
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Divider(
                        height: 10,
                        thickness: 1,
                      ),
                      Text(
                        "Capital",
                        style: TextStyle(color: ColorP[4], fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.data["capital"] ?? "N.A.",
                        style: TextStyle(color: ColorP[1], fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.data["languages"].length > 0)
                        Text(
                          "Language",
                          style: TextStyle(color: ColorP[4], fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      if (widget.data["languages"].length > 0)
                        Text(
                          '${widget.data["languages"][0]["name"] ?? "N.A."}(${widget.data["languages"][0]["native"] ?? "N.A."})',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ColorP[1], fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      Text(
                        "Currency",
                        style: TextStyle(color: ColorP[4], fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.data["currency"] ?? "N.A.",
                        style: TextStyle(color: ColorP[1], fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Dial Code",
                        style: TextStyle(color: ColorP[4], fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '+${widget.data["phone"] ?? "N.A."}',
                        style: TextStyle(color: ColorP[1], fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Icon(
                  (_toggleS)
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                )
              ],
            ),
          )),
    );
  }
}
