import 'package:covid_app_v2/utils/decorations.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worldData;
  final String formattedDate;
  const WorldWidePanel({Key key, @required this.worldData, this.formattedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: worldData['cases'].toDouble());
    FlutterMoneyFormatter fmf1 =
        FlutterMoneyFormatter(amount: worldData['deaths'].toDouble());
    FlutterMoneyFormatter fmf2 =
        FlutterMoneyFormatter(amount: worldData['recovered'].toDouble());
    FlutterMoneyFormatter fmf3 =
        FlutterMoneyFormatter(amount: worldData['tests'].toDouble());
    FlutterMoneyFormatter fmf4 =
        FlutterMoneyFormatter(amount: worldData['todayDeaths'].toDouble());
    FlutterMoneyFormatter fmf5 =
        FlutterMoneyFormatter(amount: worldData['todayCases'].toDouble());
    FlutterMoneyFormatter fmf6 =
        FlutterMoneyFormatter(amount: worldData['critical'].toDouble());
    FlutterMoneyFormatter fmf7 =
        FlutterMoneyFormatter(amount: worldData['active'].toDouble());
    MoneyFormatterOutput fo = fmf.output;
    MoneyFormatterOutput fo1 = fmf1.output;
    MoneyFormatterOutput fo2 = fmf2.output;
    MoneyFormatterOutput fo3 = fmf3.output;
    MoneyFormatterOutput fo4 = fmf4.output;
    MoneyFormatterOutput fo5 = fmf5.output;
    MoneyFormatterOutput fo6 = fmf6.output;
    MoneyFormatterOutput fo7 = fmf7.output;

    double num = worldData['deaths'] / worldData['cases'];
    double fatalRate = num * 100;
    double num1 = worldData['recovered'] / worldData['cases'];
    double recoveryRate = num1 * 100;
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Global',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
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
                  title: 'CONFIRMED',
                  panelColor: Colors.red[700],
                  textColor: Colors.red[50],
                  count: fo.withoutFractionDigits.toString(),
                  svg: "infected.svg",
                ),
                StatusPanel(
                  title: 'RECOVERED',
                  panelColor: Colors.green[700],
                  textColor: Colors.green[50],
                  count: fo2.withoutFractionDigits.toString(),
                  rate: recoveryRate.toStringAsFixed(2),
                  svg: "patient.svg",
                ),
                StatusPanel(
                  title: 'DEATHS',
                  panelColor: Colors.grey[900],
                  textColor: Colors.white,
                  count: fo1.withoutFractionDigits.toString(),
                  rate: fatalRate.toStringAsFixed(2),
                  svg: "coffin.svg",
                ),
                StatusPanel(
                  title: 'TESTED',
                  panelColor: Colors.blue[800],
                  textColor: Colors.blue[50],
                  count: fo3.withoutFractionDigits.toString(),
                  svg: "search.svg",
                ),
              ]),
          SizedBox(
            height: 10,
          ),
          Text('Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          GridView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              children: <Widget>[
                StatusPanel(
                  title: 'CONFIRMED',
                  panelColor: Colors.red[700],
                  textColor: Colors.red[50],
                  count: fo5.withoutFractionDigits.toString(),
                  svg: "infected.svg",
                ),
                StatusPanel(
                  title: 'DEATHS',
                  panelColor: Colors.grey[900],
                  textColor: Colors.white,
                  count: fo4.withoutFractionDigits.toString(),
                  svg: "coffin.svg",
                ),
                StatusPanel(
                  title: 'ACTIVE',
                  panelColor: Colors.grey[500],
                  textColor: Colors.grey[900],
                  count: fo7.withoutFractionDigits.toString(),
                  svg: "human.svg",
                ),
                StatusPanel(
                  title: 'CRITICAL',
                  panelColor: Colors.red[900],
                  textColor: Colors.red[50],
                  count: fo6.withoutFractionDigits.toString(),
                  svg: "hospital.svg",
                ),
              ]),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  final String rate;
  final String svg;
  const StatusPanel(
      {Key key,
      this.panelColor,
      this.textColor,
      this.title,
      this.count,
      this.rate = '',
      this.svg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 5),
      decoration: BoxDecorations.boxDecorationStyle.copyWith(color: panelColor),
      margin: const EdgeInsets.all(5),
      height: 20,
      width: width / 2,
      //color: panelColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex:2,
            child: SvgPicture.asset(
              'assets/svg/' + svg,
              height: 30,
              width: 30,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    )),
                Spacer(),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                rate == ''
                    ? Container(
                        padding: EdgeInsets.all(0),
                      )
                    : Text(
                        'Rate: ' + rate + '%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
