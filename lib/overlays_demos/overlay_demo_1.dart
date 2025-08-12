import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay/commons.dart';

// Demo

// First Demo

class OverlayDemo1 extends StatelessWidget {
  const OverlayDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              gapH(),
              const BasicOverlay(),
              gapH(),
              const AnimatedOverlay(),
              gapH(),
              const OverlayPosition(
                position: "Top",
                color: Color(0xFFA1167C),
                fromTop: true,
              ),
              gapH(),
              const OverlayPosition(
                position: "Bottom",
                color: Color(0xFF1EFC6C),
                fromTop: false,
              ),
              gapH(),
              const OverlayWithAutoDispose(),
              gapH(),
              const OverlayWithAnimatedIcon(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Example 1
/// Basic usaege of the [OverlayPortal]

class BasicOverlay extends StatefulWidget {
  const BasicOverlay({super.key});

  @override
  State<BasicOverlay> createState() => _BasicOverlayState();
}

class _BasicOverlayState extends State<BasicOverlay> {
  final OverlayPortalController _basicController = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .8,
      height: context.screenHeight * .07,
      child: MaterialButton(
        onPressed: () {
          _basicController.toggle();
        },
        color: const Color(0xFFe01f0a),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius(15.0),
        ),
        child: OverlayPortal(
          controller: _basicController,
          overlayChildBuilder: (context) {
            return Positioned(
              right: 0.0,
              left: 0.0,
              top: context.screenHeight * .3,
              child: Align(
                child: Container(
                  padding: padding(10.0),
                  margin: padding(10.0),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius(15.0),
                    color: const Color(0xFF3f3f3f),
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildItem(
                        "Info",
                        const Icon(
                          Icons.info,
                          color: Colors.green,
                        ),
                      ),
                      const Divider(),
                      _buildItem(
                        "Copy",
                        const Icon(
                          Icons.copy,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: const Text("Show Basic Overlay"),
        ),
      ),
    );
  }

  Widget _buildItem(
    String title,
    Icon icon,
  ) {
    return Row(
      children: <Widget>[
        icon,
        gapW(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Example 2
/// Animate [OverlayPortal]'s child while opening

class AnimatedOverlay extends StatefulWidget {
  const AnimatedOverlay({super.key});

  @override
  State<AnimatedOverlay> createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<AnimatedOverlay> {
  final OverlayPortalController _animatedController = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return SharedButton(
      onTap: () {
        _animatedController.toggle();
      },
      color: const Color(0xFFFCC719),
      child: OverlayPortal(
        controller: _animatedController,
        overlayChildBuilder: (context) {
          return Positioned(
            top: context.screenHeight * .42,
            left: context.screenWidth * .4,
            child: ClipRRect(
              borderRadius: borderRadius(15.0),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 0.0,
                      end: context.screenHeight * .28,
                    ),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, height, _) {
                      return Container(
                        padding: padding(10.0),
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: borderRadius(15.0),
                          border: Border.all(color: Colors.white24),
                          color: Colors.black38,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              const OverlayItem(
                                icon: Icon(Icons.share),
                              ),
                              gapH(0.01),
                              const OverlayItem(
                                icon: Icon(Icons.copy),
                              ),
                              gapH(0.01),
                              const OverlayItem(
                                icon: Icon(Icons.refresh),
                              ),
                              gapH(0.01),
                              const OverlayItem(
                                icon: Icon(Icons.report),
                              ),
                              gapH(0.01),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: const Text("Animated Overlay"),
      ),
    );
  }
}

class OverlayItem extends StatelessWidget {
  const OverlayItem({
    super.key,
    required this.icon,
  });
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: const Color(0xFF1b3c53),
      child: icon,
    );
  }
}

// Example 3
/// Animate Overlay Position
///

class OverlayPosition extends StatefulWidget {
  const OverlayPosition({
    super.key,
    required this.color,
    required this.fromTop,
    required this.position,
  });
  final bool fromTop;
  final String position;
  final Color color;

  @override
  State<OverlayPosition> createState() => _OverlayPositionState();
}

class _OverlayPositionState extends State<OverlayPosition> {
  final OverlayPortalController positionController = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return SharedButton(
      onTap: () async {
        positionController.toggle();
      },
      color: widget.color,
      child: OverlayPortal(
        controller: positionController,
        overlayChildBuilder: (context) {
          return TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 0.0,
              end: widget.fromTop
                  ? context.screenHeight * .52
                  : context.screenHeight * .29,
            ),
            duration: const Duration(milliseconds: 400),
            builder: (context, value, child) {
              return Positioned(
                right: 10.0,
                left: 10.0,
                top: widget.fromTop ? value : null,
                bottom: widget.fromTop ? null : value,
                child: ClipRRect(
                  borderRadius: borderRadius(15.0),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: padding(10.0),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius(15.0),
                          color: Colors.black26,
                          border: Border.all(
                            color: Colors.white38,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            widget.fromTop
                                ? const Icon(Icons.info, color: Colors.amber)
                                : const Icon(
                                    Icons.done_outline_rounded,
                                    color: Colors.green,
                                  ),
                            gapW(),
                            const Expanded(
                              child: Text(
                                "This text will appear inside the builder of the overlay widget",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                positionController.hide();
                              },
                              icon: const Icon(Icons.clear),
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
        child: Text("Animate ${widget.position} Position Overlay"),
      ),
    );
  }
}

// Example 4

/// Using [OverlayPortal] with animated Scale and auto-dispose

class OverlayWithAutoDispose extends StatefulWidget {
  const OverlayWithAutoDispose({super.key});

  @override
  State<OverlayWithAutoDispose> createState() => _OverlayWithAutoDisposeState();
}

class _OverlayWithAutoDisposeState extends State<OverlayWithAutoDispose> {
  final OverlayPortalController autoDiposeController =
      OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return SharedButton(
      onTap: () async {
        autoDiposeController.toggle();
        await Future.delayed(const Duration(milliseconds: 1400));
        autoDiposeController.hide();
      },
      color: const Color(0xFFB58AA0),
      child: OverlayPortal(
        controller: autoDiposeController,
        overlayChildBuilder: (context) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 400),
            builder: (context, scale, __) {
              return Positioned(
                top: context.screenHeight * .4,
                right: 15.0,
                left: 15.0,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    padding: padding(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF282828),
                      borderRadius: borderRadius(15.0),
                      border: Border.all(color: Colors.white38, width: 1.6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.cleaning_services_rounded,
                          size: 80,
                          color: Colors.blue,
                        ),
                        gapH(),
                        const Text(
                          "This Overlay will auto-dispose after 1000 ms from showing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        gapH(),
                        SizedBox(
                          width: context.screenWidth * .6,
                          height: context.screenHeight * .07,
                          child: MaterialButton(
                            onPressed: () {
                              autoDiposeController.hide();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: borderRadius(10.0),
                            ),
                            color: const Color(0xFF48361f),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.cancel),
                                gapW(),
                                const Text("Manual dispose")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text("Overlay with Auto-dispose"),
      ),
    );
  }
}

// Example 5
/// Overlay with animated Icon as controller

class OverlayWithAnimatedIcon extends StatefulWidget {
  const OverlayWithAnimatedIcon({super.key});

  @override
  State<OverlayWithAnimatedIcon> createState() =>
      _OverlayWithAnimatedIconState();
}

class _OverlayWithAnimatedIconState extends State<OverlayWithAnimatedIcon> {
  final OverlayPortalController iconController = OverlayPortalController();

  bool isShowing = false;

  void toggle() {
    iconController.toggle();

    setState(() {
      isShowing = iconController.isShowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * .8,
      padding: padding(5.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius(20.0),
        border: Border.all(color: Colors.white60),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius(20.0),
          onTap: () {
            toggle();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                child: OverlayPortal(
                  controller: iconController,
                  overlayChildBuilder: (context) {
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: -500, end: 0.0),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, position, _) {
                        return Positioned(
                          bottom: 20,
                          right: position,
                          left: -position,
                          child: Container(
                            padding: padding(10.0),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius(10.0),
                              border:
                                  Border.all(color: Colors.black45, width: 1.7),
                              color: const Color(0xFF201d1e),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.info,
                                          color: Colors.green,
                                        ),
                                        gapW(),
                                        const Text(
                                          "OverlayPortal",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        toggle();
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "Animated icon",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "This Overlay with animated slide and animated icon ",
                                ),
                                SizedBox(
                                  width: context.screenWidth * .3,
                                  height: context.screenHeight * .05,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: borderRadius(7.0),
                                    ),
                                    color: Colors.blue,
                                    child: const Text("Learn more"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: isShowing
                        ? const Icon(
                            Icons.clear,
                            size: 30,
                            color: Colors.red,
                            key: ValueKey("Hide_Icon"),
                          )
                        : const Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Colors.blue,
                            key: ValueKey("Show_Icon"),
                          ),
                  ),
                ),
              ),
              gapW(),
              Text(
                "Overlay Animated Icon",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isShowing ? Colors.red : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
