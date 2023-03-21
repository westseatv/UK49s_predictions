import 'package:get/get.dart';

import '../controllers/controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
