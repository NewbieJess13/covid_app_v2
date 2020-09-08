import 'dart:wasm';

import 'package:countup/countup.dart';
import 'package:covid_app_v2/utils/decorations.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhilPanel extends StatelessWidget {
  final Map philData;
  final String formattedDate;
  const PhilPanel({Key key, @required this.philData, this.formattedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double num = philData['deaths'] / philData['cases'];
    double fatalRate = num * 100;
    double num1 = philData['recovered'] / philData['cases'];
    double recoveryRate = num1 * 100;
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
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
                            duration: Duration(seconds: 1),
                            separator: ',',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Tested:',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54)),
                        Countup(
                          begin: 0,
                          end: philData['tests'].toDouble(),
                          duration: Duration(seconds: 1),
                          separator: ',',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          Divider(
            indent: 5,
            endIndent: 5,
          ),
          SizedBox(height: 20),
          Text('Total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          GridView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
              children: <Widget>[
                StatusPanel(
                  title: 'Cases',
                  panelColor: Colors.red[600],
                  textColor: Colors.red[50],
                  count: philData['cases'].toDouble(),
                  svg: "infected.svg",
                ),
                StatusPanel(
                  title: 'Deaths',
                  panelColor: Colors.grey[900],
                  textColor: Colors.white,
                  count: philData['deaths'].toDouble(),
                  // rate: fatalRate.toStringAsFixed(2),
                  svg: "coffin.svg",
                ),
                StatusPanel(
                  title: 'Recovered',
                  panelColor: Colors.green[800],
                  textColor: Colors.green[50],
                  count: philData['recovered'].toDouble(),
                  // rate: recoveryRate.toStringAsFixed(2),
                  svg: "patient.svg",
                ),
                StatusPanel(
                  title: 'Active',
                  panelColor: Colors.blue[800],
                  textColor: Colors.blue[50],
                  count: philData['active'].toDouble(),
                  svg: "search.svg",
                ),
              ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            indent: 5,
            endIndent: 5,
          ),
          Text(
            'Today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          GridView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
            ),
            children: <Widget>[
              StatusPanel(
                title: 'Cases',
                panelColor: Colors.red[700],
                textColor: Colors.red[50],
                count: philData['todayCases'].toDouble(),
                svg: "infected.svg",
              ),
              StatusPanel(
                title: 'Recoveries',
                panelColor: Colors.green[800],
                textColor: Colors.green[100],
                count: philData['todayRecovered'].toDouble(),
                svg: "patient.svg",
              ),
              StatusPanel(
                title: 'Deaths',
                panelColor: Colors.grey[900],
                textColor: Colors.white,
                count: philData['todayDeaths'].toDouble(),
                svg: "coffin.svg",
              ),
              StatusPanel(
                title: 'Critical',
                panelColor: Colors.deepPurple[800],
                textColor: Colors.purple[50],
                count: philData['critical'].toDouble(),
                svg: "hospital.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final double count;
  final String rate;
  final String svg;
  const StatusPanel({
    Key key,
    this.panelColor,
    this.textColor,
    this.title,
    this.count,
    this.rate = '',
    this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      decoration: BoxDecorations.boxDecorationStyle.copyWith(color: panelColor),
      margin: const EdgeInsets.all(5),
      height: 25,
      width: width / 2,
      //color: panelColor,
      child: Wrap(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/' + svg,
                height: 21,
                width: 21,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Countup(
                begin: 0,
                end: count,
                duration: Duration(milliseconds: 1500),
                separator: ',',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // rate == ''
              //     ? Container(
              //         padding: EdgeInsets.all(0),
              //       )
              //     : Text(
              //         'Rate: ' + rate + '%',
              //         style: TextStyle(
              //           fontSize: 13,
              //           fontWeight: FontWeight.bold,
              //           color: textColor,
              //         ),
              //       )
            ],
          ),
        ),
      ]),
    );
  }
}
