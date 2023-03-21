import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uk49s_predictions/views/home_view.dart';

import 'bindings/bindings.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
      home: const HomeView(),
    ),
  );
}
