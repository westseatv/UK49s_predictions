import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uk49s_predictions/controllers/controller.dart';
import '../databases/controllers/appwrite_dbcontroller.dart';
import 'home_screen.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    final highlightsController =
        ref.watch(highlightsDatabaseControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: highlightsController.getHighlightsDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(controller: controller);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


/*

 


*/