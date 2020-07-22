import 'package:flutter/material.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
import 'package:countup/countup.dart';

class MyCountryV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 15, crossAxisCount: 1, childAspectRatio: 1.8),
        children: <Widget>[
          DataCard(
            newCount: 400,
            totalCount: 340000,
            type: 'cases',
            title: 'Confirmed Cases',
            colors: [Colors.grey[100], Colors.grey[400]],
            img: 'assets/images/cases.png',
          ),
          DataCard(
            newCount: 1000,
            totalCount: 20173,
            type: 'recoveries',
            title: 'Recoveries',
            colors: [Colors.green[50], Colors.green[700]],
            img: 'assets/images/cases.png',
          ),
          DataCard(
            newCount: 89,
            totalCount: 2756,
            type: 'deaths',
            title: 'Deaths',
            colors: [Colors.red[50], Colors.red[700]],
            img: 'assets/images/cases.png',
          ),
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

  const DataCard(
      {Key key,
      this.newCount,
      this.totalCount,
      this.type,
      this.title,
      this.colors,
      this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 15),
      height: 250,
      width: width - 25,
      decoration: BoxDecoration(
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
                        Text(
                          'added ' + type + ' today',
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
