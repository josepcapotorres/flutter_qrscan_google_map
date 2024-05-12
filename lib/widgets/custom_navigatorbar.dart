import 'package:flutter/material.dart';
import 'package:flutter_qrscan/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: "Addresses",
        ),
      ],
    );
  }
}
