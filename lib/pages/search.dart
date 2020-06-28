import 'package:covid_app_v2/utils/datasource.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate{

  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query= '';
      })
    ];
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor:  primaryBlack,
      brightness: DynamicTheme.of(context).brightness
    ) ;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      Navigator.pop(context);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList =
          query.isEmpty?
          countryList:
          countryList.where((element)=> element['country'].toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index){

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
                        suggestionList[index]['country'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.dataTextStyle,
                      ),
                      Image.network(
                        suggestionList[index]['countryInfo']['flag'],
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
                              suggestionList[index]['cases'].toString() +
                              '[+' +
                              suggestionList[index]['todayCases']
                                  .toString() +
                              ']',
                          style: TextStyles.countryStatsTextStyle
                              .copyWith(color: Colors.red[300]),
                        ),
                        Text(
                            'DEATHS:' +
                                suggestionList[index]['deaths']
                                    .toString() +
                                '[+' +
                                suggestionList[index]['todayDeaths']
                                    .toString() +
                                ']',
                            style: TextStyles.countryStatsTextStyle
                                .copyWith(color: Colors.red[600])),
                        Text(
                            'RECOVERED:' +
                                suggestionList[index]['recovered']
                                    .toString(),
                            style: TextStyles.countryStatsTextStyle
                                .copyWith(color: Colors.green[600])),
                        Text(
                            'ACTIVE:' +
                                suggestionList[index]['active']
                                    .toString(),
                            style: TextStyles.countryStatsTextStyle),
                        Text(
                            'CRITICAL:' +
                                suggestionList[index]['critical']
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
    });
  }

}