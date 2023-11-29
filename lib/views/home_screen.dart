import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';
import 'results.dart';
import 'six_balls.dart';
import 'two_balls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.controller,
  });

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Get.height * .07,
          ),
          GestureDetector(
            onTap: () {
              controller.showInterstitialAd();
              Get.to(() => const TwoBallScreen());
            },
            child: SizedBox(
              width: Get.width,
              height: Get.height * .2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: Get.height * .17,
                  width: Get.width * .5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Column(children: [
                    Container(
                      height: Get.height * .12,
                      width: Get.width * .5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://serverperkspilot.xyz/v1/storage/buckets/653aa4066c08b90c3351/files/653aa4484b6d96e31a73/view?project=65295776aa30ddc7ca13&mode=admin'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      width: Get.width * .5,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                        child: Text(
                          '2 Balls',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .03,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const SixBallScreen());
            },
            child: SizedBox(
              width: Get.width,
              height: Get.height * .2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: Get.height * .17,
                  width: Get.width * .5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Column(children: [
                    Container(
                      height: Get.height * .12,
                      width: Get.width * .5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://serverperkspilot.xyz/v1/storage/buckets/653aa4066c08b90c3351/files/653aa4484b6d96e31a73/view?project=65295776aa30ddc7ca13&mode=admin'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      width: Get.width * .5,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '6 Balls + Bonus',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: Get.height * .03,
          // ),
          SizedBox(
            width: Get.width,
            height: Get.height * .5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(() => const Results());
                },
                child: Container(
                  height: Get.height * .17,
                  width: Get.width * .5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Column(children: [
                    Container(
                      height: Get.height * .15,
                      width: Get.width * .65,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://serverperkspilot.xyz/v1/storage/buckets/653aa4066c08b90c3351/files/653aa44751888d0e9562/view?project=65295776aa30ddc7ca13&mode=admin'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      width: Get.width * .5,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                        child: Text(
                          'Results',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
          // ElevatedButton(
          //   onPressed: () {
          //     Get.to(() => const TwoBallScreen());
          //   },
          //   child: const Text('2ball'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Get.to(() => const SixBallScreen());
          //   },
          //   child: const Text('6ball'),
          // ),
        ],
      ),
    );
  }
}
