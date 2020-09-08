import 'package:flutter/material.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
import 'package:countup/countup.dart';

class MyCountryV2 extends StatelessWidget {
  final Map philData;

  const MyCountryV2({Key key, this.philData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Current Population:',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54)),
          Countup(
            begin: 0,
            end: philData['population'].toDouble(),
            duration: Duration(milliseconds: 1500),
            separator: ',',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(height: 5),
          Text('Tested:',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54)),
          Countup(
            begin: 0,
            end: philData['tests'].toDouble(),
            duration: Duration(milliseconds: 1500),
            separator: ',',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(height: 10),
          GridView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15, crossAxisCount: 1, childAspectRatio: 1.8),
            children: <Widget>[
              DataCard(
                newCount: philData['todayCases'].toDouble(),
                totalCount: philData['cases'].toDouble(),
                type: 'cases',
                title: 'Confirmed Cases',
                colors: [Colors.grey[100], Colors.grey[600]],
                img: 'assets/images/cases.png',
                shadowColor: Colors.black.withOpacity(0.4),
              ),
              DataCard(
                newCount: philData['todayRecovered'].toDouble(),
                totalCount: philData['recovered'].toDouble(),
                type: 'recoveries',
                title: 'Recoveries',
                colors: [Colors.green[50], Colors.green[800]],
                img: 'assets/images/cases.png',
                shadowColor: Colors.black.withOpacity(0.4),
              ),
              DataCard(
                newCount: philData['todayDeaths'].toDouble(),
                totalCount: philData['deaths'].toDouble(),
                type: 'deaths',
                title: 'Deaths',
                colors: [Colors.red[50], Colors.red[800]],
                img: 'assets/images/cases.png',
                shadowColor: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
          MiniCard()
        ],
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final double newCount;
  final double totalCount;
  final String type;
  final String title;
  final String img;
  final List<Color> colors;
  final Color shadowColor;

  const DataCard(
      {Key key,
      this.newCount,
      this.totalCount,
      this.type,
      this.title,
      this.colors,
      this.img,
      this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 15),
      height: 255,
      width: width - 25,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(1, 3))
          ],
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment(0.8, 0.1),
                  // colors: [Colors.grey[100], Colors.grey[400]]
                  colors: [colors[0], colors[1]]),
          borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -35,
            left: -8,
            child: Image.asset(
              //'assets/images/cases.png',
              img,
              height: 350,
              width: 250,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // Text(
                        //   '+' + newCount.toString(),
                        //   style: TextStyle(
                        //       fontSize: 35,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black87),
                        // ),
                        Row(children: <Widget>[
                          Text('+',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          Countup(
                            begin: 0,
                            end: newCount,
                            duration: Duration(seconds: 1),
                            separator: ',',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ]),

                        Text(
                          'new ' + type + ' today',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        // Text(
                        //   totalCount.toString(),
                        //   style: TextStyle(
                        //       fontSize: 35,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black87),
                        // ),
                        Countup(
                          begin: 0,
                          end: totalCount,
                          duration: Duration(seconds: 1),
                          separator: ',',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Text(
                          'total ' + type,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: <Widget>[
        Text(
          'Active',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Spacer(),
        Countup(
          begin: 0,
          end: 1000,
          duration: Duration(seconds: 1),
          separator: ',',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ]),
    );
  }
}
