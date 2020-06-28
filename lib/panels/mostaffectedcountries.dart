import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 1,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _cardSlider(context, index, countryData);
          },
        ));
  }
}

Widget _cardSlider(BuildContext context, int carouselIndex, List countryData) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        height: 200,
        child: PageView.builder(
            itemCount: 5,
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              FlutterMoneyFormatter cases = FlutterMoneyFormatter(
                  amount: countryData[itemIndex]['cases'].toDouble());
              FlutterMoneyFormatter deaths = FlutterMoneyFormatter(
                  amount: countryData[itemIndex]['deaths'].toDouble());
              FlutterMoneyFormatter recovered = FlutterMoneyFormatter(
                  amount: countryData[itemIndex]['recovered'].toDouble());
              MoneyFormatterOutput casesOut = cases.output;
              MoneyFormatterOutput deathsOut = deaths.output;
              MoneyFormatterOutput recoveredOut = recovered.output;
              return _buildCarouselItem(
                  context,
                  carouselIndex,
                  itemIndex,
                  countryData,
                  casesOut.withoutFractionDigits,
                  deathsOut.withoutFractionDigits,
                  recoveredOut.withoutFractionDigits);
            }),
      )
    ],
  );
}

Widget _buildCarouselItem(
    BuildContext context,
    int carouselIndex,
    int itemIndex,
    List countryData,
    String caseOut,
    String deathsOut,
    String recoveredOut) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Card(
      color: Colors.blue[400],
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 15,
              top: 10,
              child: Opacity(
                  opacity: 0.7,
                  child: Image.network(
                      'https://assets.website-files.com/5d9ba0eb5f6edb77992a99d0/5e62546c280007604ccbd27c_iconfinder_virus_disease_health_illness_medical_flu_corona_5859964.png')),
              height: 150,
              width: 150,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  countryData[itemIndex]['countryInfo']['flag'],
                  height: 30,
                  width: 65,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(countryData[itemIndex]['country'].toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Confirmed: ' + caseOut,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Text('Deaths: ' + deathsOut,
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                Text('Recovered: ' + recoveredOut,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
