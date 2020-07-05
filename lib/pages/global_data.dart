import 'package:covid_app_v2/pages/countrypage.dart';
import 'package:covid_app_v2/panels/infopanel.dart';
import 'package:covid_app_v2/panels/mostaffectedcountries.dart';
import 'package:covid_app_v2/panels/worldwidepanel.dart';
import 'package:covid_app_v2/utils/datasource.dart';
import 'package:covid_app_v2/utils/decorations.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
import 'package:flutter/material.dart';

class GlobalData extends StatefulWidget {
  final List countryData;
  final Map worldData;

  const GlobalData({Key key, this.countryData, this.worldData})
      : super(key: key);
  @override
  _GlobalDataState createState() => _GlobalDataState();
}

class _GlobalDataState extends State<GlobalData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//              Container(
//                alignment: Alignment.center,
//                color: Colors.deepOrange[600],
//                padding: EdgeInsets.all(10),
//                height: 80,
//                child: Text(
//                  DataSource.quote,
//                  style: TextStyles.quoteTextStyle,
//                ),
//              ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Most affected Countries',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecorations.boxDecorationStyle
                          .copyWith(color: primaryBlack),
                      child: Text('See All', style: TextStyles.buttonTextStyle),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            widget.countryData == null
                ? Container(
                    padding: EdgeInsets.all(80),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : MostAffectedPanel(
                    countryData: widget.countryData,
                  ),
            SizedBox(
              height: 10,
            ),
            // worldData == null
            //     ? Container(
            //         padding: EdgeInsets.all(55),
            //         alignment: Alignment.center,
            //         child: CircularProgressIndicator())
            //     : Padding(
            //         padding:
            //             const EdgeInsets.only(left: 5.0, right: 5.0),
            //         child: DonutPieChart(worldData)),
            widget.worldData == null
                ? Container(
                    padding: EdgeInsets.all(55),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: WorldWidePanel(
                      worldData: widget.worldData,
                    ),
                  ),

            SizedBox(
              height: 15,
            ),
            InfoPanel(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
