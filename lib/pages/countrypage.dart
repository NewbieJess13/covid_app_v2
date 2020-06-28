import 'dart:convert';

import 'package:covid_app_v2/pages/search.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  // Country data list
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){
              showSearch(context: context, delegate: Search(countryData));
            })
          ],
          elevation: 0,
          title: Text('Affected Countries'),
        ),
        body: countryData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      height: 130,
//                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                      BoxShadow(
//                          color: Colors.grey[100],
//                          blurRadius: 10,
//                          offset: Offset(0, 10))
//                    ]),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    countryData[index]['country'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.dataTextStyle,
                                  ),
                                  Image.network(
                                    countryData[index]['countryInfo']['flag'],
                                    height: 45,
                                    width: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(color: Theme.of(context).brightness==Brightness.light? Colors.black:Colors.white,
                            thickness: 1.5,
                            indent: 5,
                            endIndent: 5,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'CONFIRMED:' +
                                          countryData[index]['cases'].toString() +
                                          '[+' +
                                          countryData[index]['todayCases']
                                              .toString() +
                                          ']',
                                      style: TextStyles.countryStatsTextStyle
                                          .copyWith(color: Colors.red[300]),
                                    ),
                                    Text(
                                        'DEATHS:' +
                                            countryData[index]['deaths']
                                                .toString() +
                                            '[+' +
                                            countryData[index]['todayDeaths']
                                                .toString() +
                                            ']',
                                        style: TextStyles.countryStatsTextStyle
                                            .copyWith(color: Colors.red[600])),
                                    Text(
                                        'RECOVERED:' +
                                            countryData[index]['recovered']
                                                .toString(),
                                        style: TextStyles.countryStatsTextStyle
                                            .copyWith(color: Colors.green[600])),
                                    Text(
                                        'ACTIVE:' +
                                            countryData[index]['active']
                                                .toString(),
                                        style: TextStyles.countryStatsTextStyle),
                                    Text(
                                        'CRITICAL:' +
                                            countryData[index]['critical']
                                                .toString(),
                                        style: TextStyles.countryStatsTextStyle
                                            .copyWith(color: Colors.red[600])),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: countryData == null ? 0 : countryData.length,
              ));
  }
}
