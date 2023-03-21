import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uk49s_predictions/controllers/controller.dart';

import '../models/saved.dart';
import '../utils/time.dart';
import '../widgets/ball.dart';

class HomeView extends GetView<AppController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Teatime & Lunchtime',
                style: TextStyle(
                  fontSize: 14,
                )),
            elevation: 0,
            centerTitle: false,
            backgroundColor: const Color.fromARGB(255, 0, 25, 48),
          ),
          drawer: Drawer(
            backgroundColor: Colors.blue,
            width: Get.width * 0.8,
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.2,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 3, 74, 109),
                  ),
                  child: const Text(
                    'WEST SEA TV APP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 15, 26),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTileTheme(
                    textColor: Colors.white,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => ListTile(
                        title: Text('Item ${index + 1}'),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook_rounded),
                    label: const Text('Follow us @WEST SEA TV'),
                  ),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.saved.assignAll(controller.generated);
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
                          const Text(
                            'Main Numbers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ctrl.generate();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Predict'),
                          ),
                        ],
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
                ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      save(ctrl),
                      backgroundColor: const Color.fromARGB(255, 0, 25, 48),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 25, 48),
                    fixedSize: Size(Get.width, 30),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: const Text('Saved'),
                )
              ],
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
