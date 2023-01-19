import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/helper/router/route_path.dart';

class LegalAndSupport extends StatefulWidget {
  const LegalAndSupport({Key? key}) : super(key: key);

  @override
  State<LegalAndSupport> createState() => _LegalAndSupportState();
}

class _LegalAndSupportState extends State<LegalAndSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text('legal_support'.tr),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.1),
            ),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.pdf_view,
                    arguments: {"key": "privacy_policy"});
              },
              title: Text('privacy_policy'.tr),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.1),
            ),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.pdf_view,
                    arguments: {"key": "term_and_condition"});
              },
              title: Text('term_condition'.tr),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
