import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:uk49s_predictions/views/soccer_codes.dart';
import 'package:uk49s_predictions/views/home_view.dart';
import 'package:uk49s_predictions/views/vouchers.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final Color = Colors.white;

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.black,
            name: 'Homepage',
            baseStyle: const TextStyle(color: Colors.amber),
            selectedStyle: TextStyle(color: Color)),
        const HomeView(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.black,
            name: 'Soccer Codes',
            baseStyle: const TextStyle(color: Colors.amber),
            selectedStyle: TextStyle(color: Color)),
        const SoccerCodes(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.black,
            name: 'Free Vouchers',
            baseStyle: const TextStyle(color: Colors.amber),
            selectedStyle: TextStyle(color: Color)),
        const FreeVouchers(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Colors.blue,
      initPositionSelected: 0,
      elevationAppBar: 0,
      slidePercent: 55,
      backgroundColorAppBar: Colors.amber,
      withShadow: false,
      isTitleCentered: true,
      tittleAppBar: const Text('UK 49\'s Predictions'),
    );
  }
}
