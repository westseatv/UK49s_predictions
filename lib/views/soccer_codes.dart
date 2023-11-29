import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SoccerCodes extends StatefulWidget {
  const SoccerCodes({
    super.key,
  });

  @override
  State<SoccerCodes> createState() => _SoccerCodesState();
}

class _SoccerCodesState extends State<SoccerCodes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: 70,
        elevation: 12,
        centerTitle: true,
        title: const Text(
          'Soccer Codes',
          style: TextStyle(fontSize: 19),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://web.facebook.com/westseatv'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }
}
