import 'package:flutter/material.dart';
import 'package:overlay/overlays_demos/demos_navigator.dart';
import 'package:provider/provider.dart';

class OverlayMainDemo extends StatelessWidget {
  const OverlayMainDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageDemosNavigation>(builder: (context, manager, _) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: Text(!manager.isLast ? "OverlayPortal" : "ShowMenu"),
          backgroundColor: const Color(0xFF4D888C),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const DemosNavigator(),
            demos[manager.currentDemo].target,
          ],
        ),
      );
    });
  }
}
