import 'package:covid_app_v2/pages/faqpage.dart';
import 'package:covid_app_v2/utils/datasource.dart';
import 'package:covid_app_v2/utils/decorations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FaqsPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecorations.boxDecorationStyle
                  .copyWith(color: primaryBlack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('FAQs',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              launch('https://covid19responsefund.org/');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecorations.boxDecorationStyle
                  .copyWith(color: primaryBlack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('DONATE',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              launch(
                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecorations.boxDecorationStyle
                  .copyWith(color: primaryBlack),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('MYTH BUSTERS',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
