/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutPieChart extends StatelessWidget {
  final Map covidData;

  DonutPieChart( this.covidData);


  @override
  Widget build(BuildContext context) {
    final List<charts.Series> seriesList = _createDonutData();
    return Container(
     // padding: const EdgeInsets.all(50),
      margin: const EdgeInsets.all(10),
      height: 250,
      width: MediaQuery.of(context).size.width  ,
      child: Card(
        elevation: 2,
        child: new charts.PieChart(seriesList,
            animate: true,
            animationDuration: Duration(milliseconds: 1500),
            // Configure the width of the pie slices to 60px. The remaining space in
            // the chart will be left as a hole in the center.

            defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: 80,
                arcRendererDecorators: [new charts.ArcLabelDecorator(
                  insideLabelStyleSpec: new charts.TextStyleSpec(fontSize: 15),
                )]
            )),
      ),
    );
  }

  /// Create one series with sample hard coded data.
   List<charts.Series<LinearGrowth, dynamic>> _createDonutData() {
    final data = [
      new LinearGrowth('Recovered', covidData['recovered'],Colors.green[700]),
      new LinearGrowth('Deaths',covidData['deaths'],Colors.red[700]),
      new LinearGrowth('Cases', covidData['cases'],Colors.blue[700]),
     // new LinearGrowth('Cases', covidData['active'],Colors.yellow[700]),
    ];

    return [
      new charts.Series<LinearGrowth, dynamic>(
        id: 'Sales',
        domainFn: (LinearGrowth growth, _) => growth.title,
        measureFn: (LinearGrowth growth, _) => growth.growth,
        data: data,
        colorFn: (LinearGrowth growth, _) => charts.ColorUtil.fromDartColor(growth.colors),
        //labelAccessorFn: (LinearGrowth row, _) => '${row.title}: ${row.growth }',

      )
    ];
  }
}

/// Sample linear data type.
class LinearGrowth {
  final String title;
  final int growth;
  final  Color colors;

  LinearGrowth(this.title, this.growth,this.colors );
}
