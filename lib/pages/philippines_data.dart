import 'package:covid_app_v2/panels/mycountry.dart';
import 'package:covid_app_v2/panels/mycountryv2.dart';
import 'package:flutter/material.dart';

class PhilippinesTab extends StatefulWidget {
  final Map philData;

  const PhilippinesTab({Key key, this.philData}) : super(key: key);

  @override
  _PhilippinesTabState createState() => _PhilippinesTabState();
}

class _PhilippinesTabState extends State<PhilippinesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // philippinesData == null
            //     ? Container(
            //         padding: EdgeInsets.all(55),
            //         alignment: Alignment.center,
            //         child: CircularProgressIndicator())
            //     : Padding(
            //         padding:
            //             const EdgeInsets.only(left: 5.0, right: 5.0),
            //         child: DonutPieChart(philippinesData)),
          
            widget.philData == null
                ? Container(
                    padding: EdgeInsets.all(55),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    // child: PhilPanel(
                    //   philData: widget.philData,
                    child: PhilPanel(philData: widget.philData,),
                  ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
