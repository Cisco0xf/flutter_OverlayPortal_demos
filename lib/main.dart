import 'package:flutter/material.dart';
import 'package:overlay/commons.dart';
import 'package:overlay/overlays_demos/demos_navigator.dart';
import 'package:overlay/overlays_demos/main_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DemoRoot());
}

class DemoRoot extends StatelessWidget {
  const DemoRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ManageDemosNavigation()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF223248),
            brightness: Brightness.dark,
          ),
        ),
        home: const OverlayMainDemo(),
      ),
    );
  }
}
