import 'package:flutter/material.dart';
import '../components/colors.dart';

import 'components/colors.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: kMainColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'assets/images/Logo.png',
              width: 50,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/commingsoon.jpeg"),
            fit: BoxFit.fill
          )
        ),
      ),
    );
  }
}
