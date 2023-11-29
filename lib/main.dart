// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:uk49s_predictions/widgets/hidden_drawer.dart';

// import 'bindings/bindings.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       defaultTransition: Transition.fade,
//       initialBinding: AppBinding(),
//       home: const HiddenDrawer(),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uk49s_predictions/bindings/bindings.dart';
import 'package:uk49s_predictions/widgets/hidden_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: ['A7AA5575BEB62216489DFFBE3AEC3FEA']);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home: const HiddenDrawer(),
    );
  }
}
