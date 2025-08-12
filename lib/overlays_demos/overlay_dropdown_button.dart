import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay/commons.dart';
import 'package:provider/provider.dart';

class ButtonManager extends ChangeNotifier {
  static const List<String> options = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
  ];

  final OverlayPortalController buttonController = OverlayPortalController();
/*   final OverlayPortalController buttonControllerToast = OverlayPortalController();
 */
  String defaultOption = "Show Custom DropDown";

  int? currentOption;

  void selectNewOption({required int target, bool showToast = false}) {
    currentOption = target;

    defaultOption = options[currentOption!];

/* 
    if(showToast) {
      buttonControllerToast.hide();

    } else {
      buttonController.hide();
    }
 */
    buttonController.hide();

    checkStatus();
    notifyListeners();
  }

  // Showing Status

  bool isShowing = false;

  void checkStatus() {
    isShowing = buttonController.isShowing;

    notifyListeners();
  }

  // Show toast

  //final OverlayPortalController toastController = OverlayPortalController();

  /*  Future<void> showOverlayToast() async {
    toastController.toggle();

    await Future.delayed(const Duration(milliseconds: 1000));

    toastController.hide();
  } */
}

class OverlayDropDownButton extends StatefulWidget {
  const OverlayDropDownButton({super.key});

  @override
  State<OverlayDropDownButton> createState() => _OverlayDropDownButtonState();
}

class _OverlayDropDownButtonState extends State<OverlayDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        gapH(),
        const Text(
          "Show Custom Drop Without Custom Tosat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonManager(),
          child: Consumer<ButtonManager>(
            builder: (context, manager, _) {
              return CusomDropDownButton(
                showToast: false,
                manager: manager,
              );
            },
          ),
        ),
        const Divider(),
        const Text(
          "Show Custom Drop With Custom Tosat",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonManager(),
          child: Consumer<ButtonManager>(
            builder: (context, manager, _) {
              return CusomDropDownButton(
                showToast: true,
                manager: manager,
              );
            },
          ),
        ),
        const FlutterLogo(size: 250),
      ],
    );
  }
}

class CusomDropDownButton extends StatelessWidget {
  const CusomDropDownButton({
    super.key,
    required this.showToast,
    required this.manager,
  });

  final ButtonManager manager;

  final bool showToast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30, width: 1.7),
        color: const Color(0xFF71958e),
        borderRadius: borderRadius(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            manager.buttonController.toggle();
            manager.checkStatus();
          },
          borderRadius: borderRadius(15.0),
          child: Padding(
            padding: padding(15.0),
            child: OverlayPortal(
              controller: manager.buttonController,
              overlayChildBuilder: (context) {
                return Positioned(
                  top: showToast
                      ? context.screenHeight * .52
                      : context.screenHeight * .36,
                  left: 10.0,
                  right: 10.0,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 10,
                      end: context.screenHeight * .43,
                    ),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, height, _) {
                      return ClipRRect(
                        borderRadius: borderRadius(15.0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              height: height,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius(15.0),
                                border: Border.all(
                                  color: Colors.white38,
                                  width: 1.6,
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    ButtonManager.options.length,
                                    (index) {
                                      return showToast
                                          ? DropDownOverlayItemWithToast(
                                              index: index,
                                              isSelected:
                                                  manager.currentOption == null
                                                      ? false
                                                      : manager.currentOption ==
                                                          index,
                                              onSelect: () {
                                                manager.selectNewOption(
                                                    target: index);
                                              },
                                            )
                                          : DropDownOverlayItem(
                                              index: index,
                                              isSelected:
                                                  manager.currentOption == null
                                                      ? false
                                                      : manager.currentOption ==
                                                          index,
                                              onSelect: () {
                                                manager.selectNewOption(
                                                  target: index,
                                                );
                                              },
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  const Icon(Icons.water_drop_sharp),
                  gapW(),
                  Text(
                    manager.defaultOption,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  manager.isShowing
                      ? const Icon(Icons.keyboard_arrow_up_rounded)
                      : const Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Noraml Item

class DropDownOverlayItem extends StatelessWidget {
  const DropDownOverlayItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  });

  final int index;
  final bool isSelected;

  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(10.0),
      decoration: BoxDecoration(
        border:
            isSelected ? Border.all(color: Colors.white24, width: 1.7) : null,
        color: isSelected ? const Color(0xFF3f3f3f) : null,
        borderRadius: borderRadius(10.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelect,
          borderRadius: borderRadius(10.0),
          child: Padding(
            padding: padding(7.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  child: Text("${index + 1}"),
                ),
                gapW(),
                Text(
                  ButtonManager.options[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : null,
                    color: isSelected ? Colors.green : null,
                  ),
                ),
                const Expanded(child: SizedBox()),
                if (isSelected) ...{
                  const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Item that when clicked the toast overlay shows up

class DropDownOverlayItemWithToast extends StatefulWidget {
  const DropDownOverlayItemWithToast({
    super.key,
    required this.index,
    required this.isSelected,
    /* required this.controller, */
    required this.onSelect,
  });

  final int index;
  final bool isSelected;

  /* final OverlayPortalController controller; */

  final void Function() onSelect;

  @override
  State<DropDownOverlayItemWithToast> createState() =>
      _DropDownOverlayItemWithToastState();
}

class _DropDownOverlayItemWithToastState
    extends State<DropDownOverlayItemWithToast> {
  final OverlayPortalController controller = OverlayPortalController();

  Future<void> showOverlayToast() async {
    controller.show();

    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      controller.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Positioned(
              bottom: 40 * value,
              right: 0.0,
              left: 0.0,
              child: Align(
                child: Transform.scale(
                  scale: 0.7 + (0.3 * value),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      width: context.screenWidth * .5,
                      padding: padding(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF575757),
                        borderRadius: borderRadius(10.0),
                        border: Border.all(color: Colors.white12, width: 1.5),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.info),
                          gapW(),
                          Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ButtonManager.options[widget.index],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text: " : Activated",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: padding(10.0),
        decoration: BoxDecoration(
          border: widget.isSelected
              ? Border.all(color: Colors.white24, width: 1.7)
              : null,
          color: widget.isSelected ? const Color(0xFF3f3f3f) : null,
          borderRadius: borderRadius(10.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              await showOverlayToast();
              widget.onSelect();
            },
            borderRadius: borderRadius(10.0),
            child: Padding(
              padding: padding(7.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    child: Text("${widget.index + 1}"),
                  ),
                  gapW(),
                  Text(
                    ButtonManager.options[widget.index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: widget.isSelected ? FontWeight.bold : null,
                      color: widget.isSelected ? Colors.green : null,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  if (widget.isSelected) ...{
                    const Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                  }
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
