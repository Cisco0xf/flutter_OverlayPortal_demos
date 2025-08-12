import 'package:flutter/material.dart';
import 'package:overlay/commons.dart';

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

class MenuItem {
  final String title;
  final Icon icon;

  const MenuItem({
    required this.icon,
    required this.title,
  });
}

const List<MenuItem> items = <MenuItem>[
  MenuItem(icon: Icon(Icons.copy), title: "Copy"),
  MenuItem(icon: Icon(Icons.refresh), title: "Reset"),
  MenuItem(icon: Icon(Icons.report), title: "Report"),
  MenuItem(icon: Icon(Icons.share), title: "Share"),
];

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
