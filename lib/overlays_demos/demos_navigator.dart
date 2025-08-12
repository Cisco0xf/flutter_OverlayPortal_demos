import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:overlay/commons.dart';
import 'package:overlay/overlays_demos/overlay_demo_basic.dart';
import 'package:overlay/overlays_demos/overlay_dropdown_button.dart';
import 'package:overlay/overlays_demos/overlay_with_builder.dart';
import 'package:provider/provider.dart';

// Manage navigation

class ManageDemosNavigation extends ChangeNotifier {
  int currentDemo = 0;

  void changeDemo(int target) {
    currentDemo = target;

    log("Target Demo => $target");

    notifyListeners();
  }

  bool get isLast => currentDemo ==2;
}

// Demo Model

class DemoModel {
  final String title;
  final IconData icon;
  final Widget target;

  const DemoModel({
    required this.icon,
    required this.title,
    required this.target,
  });
}

const List<DemoModel> demos = [
  DemoModel(
    icon: Icons.info,
    title: "Overlay Dialog",
    target: OverlayDemo1(),
  ),
  DemoModel(
    icon: Icons.info,
    title: "Custom DropDown",
    target: OverlayDropDownButton(),
  ),
  DemoModel(
    icon: Icons.info,
    title: "Overlay With Builder",
    target: OverlayWithBuilder(),
  ),
];

class DemosNavigator extends StatelessWidget {
  const DemosNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: context.screenHeight * .1,
          child: Consumer<ManageDemosNavigation>(
            builder: (context, nav, _) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: demos.length,
                itemBuilder: (context, index) {
                  return DemoItem(
                    isSelected: nav.currentDemo == index,
                    item: demos[index].title,
                    onSelect: () {
                      nav.changeDemo(index);
                    },
                    icon: demos[index].icon,
                  );
                },
              );
            },
          ),
        ),
        const Divider(height: 0.0),
      ],
    );
  }
}

class DemoItem extends StatelessWidget {
  const DemoItem({
    super.key,
    required this.isSelected,
    required this.item,
    required this.onSelect,
    required this.icon,
  });

  final String item;
  final bool isSelected;
  final void Function() onSelect;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          margin: padding(10.0),
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF785ab8) : const Color(0xFF977dc8),
            border: isSelected
                ? Border.all(color: Colors.white30, width: 1.6)
                : null,
            borderRadius: borderRadius(isSelected ? 15.0 : 10.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSelect,
              child: Padding(
                padding: padding(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icon),
                    gapW(0.02),
                    Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //gapH(0.01),
        if (isSelected)
          TweenAnimationBuilder(
            tween: Tween(
              begin: 10.0,
              end: context.screenWidth * .2,
            ),
            duration: const Duration(milliseconds: 400),
            builder: (context, value, child) {
              return Container(
                width: value,
                height: 4.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: Colors.blue,
                ),
              );
            },
          )
      ],
    );
  }
}
