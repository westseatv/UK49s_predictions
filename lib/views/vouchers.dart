import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FreeVouchers extends StatefulWidget {
  const FreeVouchers({
    super.key,
  });

  @override
  State<FreeVouchers> createState() => _FreeVouchersState();
}

class _FreeVouchersState extends State<FreeVouchers> {
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
          'Free Vouchers',
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
          url: Uri.parse(
              'https://play.google.com/store/apps/details?id=com.westseatv.app.mo4mo.mo4mo&hl=en&gl=US'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(),
        ),
      ),
    );
  }
}
