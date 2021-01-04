import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';

class AnIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool button;
  AnIcon(this.icon, {this.color, this.button = false});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = color ?? getColor(context, button ? ColorType.BUTTON_TEXT : ColorType.TEXT);
    return Icon(icon, size: DEFAULT_ICON_SIZE, color: iconColor);
  }
}

class AnImageIcon extends Image {
  final String url;
  AnImageIcon(this.url) : super(image: AssetImage(url), width: DEFAULT_ICON_SIZE, height: DEFAULT_ICON_SIZE);
}
