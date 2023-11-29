import 'dart:io' as platiform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uk49s_predictions/controllers/controller.dart';

import '../models/saved.dart';
import '../utils/time.dart';
import '../widgets/ball.dart';

class SixBallScreen extends GetView<AppController> {
  const SixBallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      initState: (state) {
        controller.createBannnerAd();
        controller.createInterstitialAd();
      },
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.blueAccent,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            toolbarHeight: 70,
            elevation: 12,
            centerTitle: true,
            title: const Text(
              'Lunchtime & Teatime',
              style: TextStyle(fontSize: 19),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            automaticallyImplyLeading: false,
            leading: Container(
              padding: const EdgeInsets.all(3),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 27,
                    )),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * .85,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, bottom: 10, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          color: Colors.black,
                        ),
                        child: const Text(
                          '6 Balls + Bonus',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Container(
                        width: Get.width * .85,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width * .22,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.saved
                                      .assignAll(controller.generated);
                                  if (!controller.localDb
                                      .readSavedNumbers()
                                      .contains(Saved(
                                        numbers: ctrl.saved,
                                        date: time(),
                                      ))) {
                                    ctrl.localDb.saveNumbers(Saved(
                                      numbers: ctrl.saved,
                                      date: time(),
                                    ));
                                    ctrl.localDb.savedBox.save();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Save'),
                              ),
                            ),
                            const Text(
                              'Main Set',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: Get.width * .22,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ElevatedButton(
                                onPressed: () {
                                  ctrl.generate();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Predict'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: balls,
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Bonus',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ball(controller.generated[6], 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              controller.showInterstitialAd();
              Get.bottomSheet(
                save(ctrl),
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
              );
            },
            child: const Center(
              child: Text(
                'Saved',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          bottomNavigationBar:
              ctrl.bannerAd == null && platiform.Platform.isAndroid
                  ? null
                  : StatefulBuilder(
                      builder: (context, setState) => Container(
                        height: 52,
                        width: Get.width,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: AdWidget(ad: ctrl.bannerAd),
                      ),
                    ),
        );
      },
    );
  }

  Widget save(AppController ctrl) {
    List<Saved> data = controller.localDb.readSavedNumbers();
    return Column(
      children: [
        Expanded(
          child: data.isNotEmpty
              ? ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemBuilder: (context, index) => ListTile(
                    textColor: Colors.white,
                    tileColor: const Color.fromARGB(255, 17, 36, 54),
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: data[index]
                              .numbers
                              .map(
                                (number) => Expanded(
                                  child: Ball(
                                    number: number,
                                    small: true,
                                    color: number == data[index].numbers.last
                                        ? Colors.orange
                                        : null,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 20),
                      child: Text(
                        data[index].date,
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Empty...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
        ),
        data.isEmpty
            ? const SizedBox.shrink()
            : ElevatedButton.icon(
                onPressed: () {
                  controller.localDb.clearAll();
                  navigator!.pop();
                  ctrl.update();
                },
                icon: const Icon(Icons.delete),
                label: const Text('Clear All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(Get.width, 30),
                ),
              )
      ],
    );
  }

  List<Widget> get balls {
    return [
      const SizedBox(width: 10),
      Expanded(child: ball(controller.generated[0], 0)),
      Expanded(child: ball(controller.generated[1], 1)),
      Expanded(child: ball(controller.generated[2], 2)),
      Expanded(child: ball(controller.generated[3], 3)),
      Expanded(child: ball(controller.generated[4], 4)),
      Expanded(child: ball(controller.generated[5], 5)),
      const SizedBox(width: 10),
    ];
  }

  Widget ball(int number, int i) {
    return Ball(
      number: number,
      color: controller.colors[i],
    );
  }
}
