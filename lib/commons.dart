import 'package:flutter/material.dart';

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);

EdgeInsetsGeometry padding(double padding) => EdgeInsets.all(padding);

// Navigator Key

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// App Dimenssion'

extension AppDimenssion on BuildContext {
  double get screenWidth {
    final double width = MediaQuery.sizeOf(this).width;
    return width;
  }

  double get screenHeight {
    final double height = MediaQuery.sizeOf(this).height;
    return height;
  }
}

// Width gaps 

final BuildContext context = navigatorKey.currentContext as BuildContext;

SizedBox gapW([double ratio = 0.03]) {
  return SizedBox(
    width: context.screenWidth * ratio,
  );
}

// Height Gaps

SizedBox gapH([double ratio = 0.02]) {
  return SizedBox(
    height: context.screenHeight * ratio,
  );
}

// Button

class SharedButton extends StatelessWidget {
  const SharedButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.color,
  });

  final Widget child;
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * .8,
      height: context.screenHeight * .08,
      child: MaterialButton(
        onPressed: onTap,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius(15.0),
        ),
        child: child,
      ),
    );
  }
}
