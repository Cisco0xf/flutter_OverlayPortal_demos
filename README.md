# Flutter OverlayPortal Widget Demo

**A comprehensive Flutter demo project showcasing the power and versatility of Flutter's OverlayPortal widget through practical, real-world examples.**
> [!NOTE]
>  In the few next lines I will explain how to unlock the power of the **`OverlayPortal`** widget to build:
>
> -  **Custom Toastifications** with glassmorphism effect
> -  **Animated dialogs** with scale, fade, and position animations
> -  **Context-attached dialogs** for builders (`ListView.builder()`, `GridView.builder()`)
> -  **Custom DropdownButtons** with glassmorphism effect
> -  **Flutter Toast** with fade, scale, and position animations

## Features

- Multiple overlay implementation techniques
- Custom animated dropdown menus
- Contextual overlay menus with builder pattern
- Auto-disposing overlays
- Position-animated overlays (top/bottom)
- Overlay with animated icons
- Custom toast notifications
- Blurred background effects
- Responsive design for all screen sizes

## Code Structure:
```text
lib/
├── main.dart                        # Entry point        
├── overlay_demoes/                  # Contains all the demos      
│   ├── demos_navigator.dart         # Provider class to control the current navigation
│   ├── main_widget.dart             # Main Widget in the demo
│   ├── overlay_demo_basic.dart      # Contains all the basic overlays (1:6)
│   ├── overlay_dropdown_button.dart # Contains the custom DropDownButton
│   └── overlay_with_builder.dart
└── commons.dart                     # Common utilities and helpers
```
## Demo Examples

### 1- Show Basice `OverlayPortal` :

**Simple `OverlayPortal` implementation with static content.**

**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/basic_overlay.gif)

**2- Code:**

```dart

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

```

### 2. Animated Overlay
**Overlay with smooth height animation and blur effect.**

**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/animated_overlay.gif)

**2- Code:**

```dart

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

```

### 3. Top Animation Positioned OverlayPortal
**Overlays that animate from top positions with glassmorphism effect.**

**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/animate_top_overlay.gif)

**2- Code:**

```dart

const OverlayPosition(
    position: "Top",
    color: Color(0xFFA1167C),
    fromTop: true,
),


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

```



### 4. Bottom Animation Positioned OverlayPortal
**Overlays that animate from bottom positions with glassmorphism effect.**

**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/animate_bottom_overlay.gif)

**2- Code:**

```dart


const OverlayPosition(
    position: "Bottom",
    color: Color(0xFFA1167C),
    fromTop: false,
),


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

```
### 5. Auto-disposing Overlay
**Overlay that automatically hides after a delay.**


**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/auto-dispose.gif)

**2- Code:**

```dart

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

```

### 6. Overlay with Animated Icon
**Interactive overlay controlled by an animated icon button using `isShowing`.**


**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/overlay_with_animated_icon.gif)

**2- Code:**

```dart

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

```



### 6. Custom Dropdown Menu
**Advanced dropdown implementation using overlays with:**
- Animated entries
- Selection indicators


**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/drop_down_overlay.gif)

**2- Code:**

```dart

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

```



### 7. Custom Dropdown Menu with `OverlayPortal` Toast
**Advanced dropdown implementation using overlays with:**
- Custom toast notifications
- Animated entries
- Selection indicators


**1- Example GIF:**

![Eample1_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/drop_down_overlay.gif)

**2- Code:**

```dart

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

```


## `showMenu` To attach dialog with it's parent

![Example_GIF](https://github.com/Cisco0xf/flutter_OverlayPortal_demos/blob/main/overlay_demo_gifs/show_menu_overlay.gif)

### 1- Build the widget:

```dart

class OverlayWithBuilder extends StatelessWidget {
  const OverlayWithBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: context.screenHeight * .23,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return BuildItem(
            title: "Item ${index + 1}",
          );
        },
      ),
    );
  }
}



class BuildItem extends StatelessWidget {
  const BuildItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(10.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius(15.0),
        color: const Color(0xFF4F3757),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 5.0,
            left: 5.0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showOverlayMenu(context: context);
                },
                child: const Icon(Icons.more_vert_outlined),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.all_inclusive_rounded,
                  color: Colors.green,
                  size: 50,
                ),
                gapH(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

```

### 2- Catch the position of the parent using its context typeof `BuildContext`

```dart
 final RenderBox renderBox = context.findRenderObject() as RenderBox;

final Offset position = renderBox.localToGlobal(Offset.zero);
```

### 3- Build the `showMenu` Dialog:

```dart

// Show the menu to atach the Overlay with the widget

void showOverlayMenu({
  required BuildContext context,
}) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;

  final Offset position = renderBox.localToGlobal(Offset.zero);
  showMenu(
    context: context,
    constraints: BoxConstraints(minWidth: context.screenWidth * .34),
    position: RelativeRect.fromLTRB(
      position.dx + 30,
      position.dy + 30,
      30.0,
      0.0,
    ),
    items: [
      for (int i = 0; i < items.length; i++) ...{
        PopupMenuItem(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  items[i].icon,
                  gapW(),
                  Text(
                    items[i].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              if (i != items.length - 1) ...{
                const Divider(),
              }
            ],
          ),
        ),
      },
    ],
  );
}

```

## LICENSE

**MIT © Mahmoud Nagy**
