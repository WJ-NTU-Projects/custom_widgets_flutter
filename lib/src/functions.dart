import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';

Future<void> showADialog(BuildContext context, WidgetBuilder builder) {
  return Platform.isIOS ? showCupertinoDialog(context: context, builder: builder, useRootNavigator: false) : showDialog(context: context, builder: builder, useRootNavigator: false);
}

void showErrorDialog(BuildContext context, dynamic error, {String message = "Something went wrong."}) {
  print("ERROR: $error");
  showADialog(context, (context) => ADialog(DialogType.OK, message: message));
  //showPlatformDialog(context: context, builder: (context) => ADialog(DialogType.OK, message: ERROR_DEF));
}

Future<void> showProgressDialog(BuildContext context) {
  return showADialog(context, (context) => ADialog(DialogType.PROGRESS));
}

Future<void> hideProgressDialog(BuildContext context) async {
  Navigator.of(context).pop();
}

Future<void> showModalSheet(BuildContext context, WidgetBuilder builder, {bool root = true}) {
  return Platform.isIOS ? showCupertinoModalPopup(context: context, builder: builder, useRootNavigator: root) : showModalBottomSheet(context: context, builder: builder, useRootNavigator: root);
}

Future<T> navigate<T extends Object>(BuildContext context, Widget targetPage, {bool root = false}) {
  final Route<T> route = Platform.isIOS ? CupertinoPageRoute(builder: (context) => targetPage) : MaterialPageRoute(builder: (context) => targetPage);
  return Navigator.of(context, rootNavigator: root).push(route);
}

Future<T> navigateFinish<T extends Object>(BuildContext context, Widget targetPage) {
  final Route<T> route = Platform.isIOS ? CupertinoPageRoute(builder: (context) => targetPage) : MaterialPageRoute(builder: (context) => targetPage);
  return Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(route, (route) => false);
}

void navigatePopUntilFirst(BuildContext context, {bool root = false}) {
  Navigator.of(context, rootNavigator: root).popUntil((route) => route.isFirst);
}

Border getNavBorder(BuildContext context) {
  final Color navBorderColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? DIVIDER_COLOR_DARK : DIVIDER_COLOR;
  return Border(bottom: BorderSide(color: navBorderColor, width: 0.0, style: BorderStyle.solid));
}

Color getCardColor2(BuildContext context) {
  return Platform.isIOS ? (MediaQuery.of(context).platformBrightness == Brightness.dark ? CARD_COLOR_DARK : CARD_COLOR) : Colors.transparent;
}

Color getColor(BuildContext context, ColorType type) {
  bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

  switch (type) {
    case ColorType.PRIMARY:
      return isDarkMode ? PRIMARY_COLOR_DARK : PRIMARY_COLOR;
    case ColorType.SLIVER:
      return isDarkMode ? SLIVER_COLOR_DARK : SLIVER_COLOR;
    case ColorType.ACCENT:
      return isDarkMode ? ACCENT_COLOR_DARK : ACCENT_COLOR;
    case ColorType.MODAL:
      return isDarkMode ? MODAL_COLOR_DARK : MODAL_COLOR;
    case ColorType.CARD:
      return isDarkMode ? CARD_COLOR_DARK : CARD_COLOR;
    case ColorType.DIVIDER:
      return isDarkMode ? DIVIDER_COLOR_DARK : DIVIDER_COLOR;
    case ColorType.POSITIVE:
      return isDarkMode ? POSITIVE_COLOR_DARK : POSITIVE_COLOR;
    case ColorType.NEGATIVE:
      return isDarkMode ? NEGATIVE_COLOR_DARK : NEGATIVE_COLOR;
    case ColorType.TEXT:
      return isDarkMode ? TEXT_COLOR_DARK : TEXT_COLOR;
    case ColorType.INACTIVE:
      return isDarkMode ? INACTIVE_COLOR_DARK : INACTIVE_COLOR;
    default:
      return isDarkMode ? PRIMARY_COLOR_DARK : PRIMARY_COLOR;
  }
}
