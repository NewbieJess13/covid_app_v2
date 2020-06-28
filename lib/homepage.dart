import 'dart:convert';
import 'package:covid_app_v2/pages/countrypage.dart';
import 'package:covid_app_v2/panels/graphs.dart';
import 'package:covid_app_v2/panels/infopanel.dart';
import 'package:covid_app_v2/panels/mostaffectedcountries.dart';
import 'package:covid_app_v2/panels/mycountry.dart';
import 'package:covid_app_v2/panels/worldwidepanel.dart';
import 'package:covid_app_v2/utils/decorations.dart';
import 'package:covid_app_v2/utils/text_styles.dart';
//import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/datasource.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Total world data
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  // Country data list
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=deaths');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Map philippinesData;
  fetchPhilData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/Philippines');
    setState(() {
      philippinesData = json.decode(response.body);
    });
  }

  List philCovidTimeLine = [];
  List output = [];
  _fetchListData() async {
    http.Response response = await http.get(
        'https://api.apify.com/v2/datasets/sFSef5gfYg3soj8mb/items?format=json&clean=1');
    philCovidTimeLine = json.decode(response.body);
    // return philCovidTimeLine;
    setState(() {
      output = philCovidTimeLine
          .getRange(philCovidTimeLine.length - 5, philCovidTimeLine.length)
          .toList();
    });

    print(output.length);
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    fetchPhilData();
    _fetchListData();
  }

  TabController controller;

  @override
  void initState() {

    fetchData();
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Theme.of(context).brightness == Brightness.light
//                  ? Icons.lightbulb_outline
//                  : Icons.highlight),
//              onPressed: () {
//                DynamicTheme.of(context).setBrightness(
//                    Theme.of(context).brightness == Brightness.light
//                        ? Brightness.dark
//                        : Brightness.light);
//              })
//        ],
//        centerTitle: false,
//        title: Text("COVID-19 TRACKER"),
//        elevation: 0.0,
//      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/svg/coronavirus.svg',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'COVID-19',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.hamburger,
                      color: Colors.white,
                    ),
                    onPressed: () {})
              ],
              elevation: 8,
              expandedHeight: 225,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.1,
                          0.4,
                          0.7,
                          0.9
                        ],
                        colors: [
                          Colors.blue[400],
                          Colors.blue[700],
                          Colors.blue[800],
                          Colors.blue[900]
                        ])),
                child: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 95,
                        ),
                        Text(
                          'STAY AT HOME.',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Donate Now.',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Together we can get through this tough times. Click donate button.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.red[400], Colors.red[900]],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 150.0, minHeight: 35.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.handHoldingHeart,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Donate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            launch('https://covid19responsefund.org/');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2),
                    insets: EdgeInsets.symmetric(horizontal: 16.0)),
                tabs: [
                  Tab(
                    child: Text(
                      'Philippines',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Global',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
                controller: controller,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            Container(
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
                    SizedBox(
                      height: 10,
                    ),
                    philippinesData == null
                        ? Container(
                            padding: EdgeInsets.all(55),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator())
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: PhilPanel(
                              philData: philippinesData,
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
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
                              child: Text('See All',
                                  style: TextStyles.buttonTextStyle),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    countryData == null
                        ? Container(
                            padding: EdgeInsets.all(80),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator())
                        : MostAffectedPanel(
                            countryData: countryData,
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
                    worldData == null
                        ? Container(
                            padding: EdgeInsets.all(55),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator())
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: WorldWidePanel(
                              worldData: worldData,
                            ),
                          ),

                    SizedBox(
                      height: 15,
                    ),
                    InfoPanel(),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      'WE HEAL AS ONE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
