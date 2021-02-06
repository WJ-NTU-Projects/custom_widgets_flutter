import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';

class ADivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 0, thickness: 0.8, color: MediaQuery.of(context).platformBrightness == Brightness.dark ? DIVIDER_COLOR_DARK : DIVIDER_COLOR);
  }
}

class APositioned extends StatelessWidget {
  final Alignment align;
  final Widget child;
  APositioned(this.align, this.child);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(child: Align(alignment: align, child: child));
  }
}

class AProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator();
  }
}

class AWaitingUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: AProgressIndicator());
  }
}

class AnErrorUI extends StatelessWidget {
  final Object error;
  AnErrorUI(this.error);

  @override
  Widget build(BuildContext context) {
    print("ERROR: $error");
    return Padding(padding: EdgeInsets.all(DEFAULT_MARGIN), child: Center(child: AText("Something went wrong.")));
  }
}

class GestureField extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  GestureField({@required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Border border = Border.all(color: getColor(context, ColorType.DIVIDER));
    final BorderRadius radius = BorderRadius.all(Radius.circular(MARGIN_Q));
    final BoxDecoration decoration = BoxDecoration(border: border, borderRadius: radius);
    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(vertical: DEFAULT_MARGIN * 0.75, horizontal: DEFAULT_MARGIN * 0.5);
    final Widget child = Container(child: Padding(padding: padding, child: Center(child: this.child)), decoration: decoration);
    return GestureDetector(child: child, onTap: this.onTap);
  }
}
