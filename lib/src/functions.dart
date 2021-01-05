import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_widgets_wj.dart';

//========================
// Dialogs & Modal Sheets
//========================
Future<void> showModalSheet(BuildContext context, WidgetBuilder builder, {bool root = true}) => Platform.isIOS ? showCupertinoModalPopup(context: context, builder: builder, useRootNavigator: root) : showModalBottomSheet(context: context, builder: builder, useRootNavigator: root);
Future<void> showProgressDialog(BuildContext context) => showADialog(context, (context) => ADialog(DialogType.PROGRESS));
Future<void> hideProgressDialog(BuildContext context) async => Navigator.of(context).pop();
Future<void> showADialog(BuildContext context, WidgetBuilder builder) => Platform.isIOS ? showCupertinoDialog(context: context, builder: builder, useRootNavigator: false) : showDialog(context: context, builder: builder, useRootNavigator: false);

void showErrorDialog(BuildContext context, dynamic error, {String message = "Something went wrong."}) {
  print("ERROR: $error");
  showADialog(context, (context) => ADialog(DialogType.OK, message: message));
}

//===========
// Navigator
//===========
void navigatePopUntilFirst(BuildContext context, {bool root = false}) => Navigator.of(context, rootNavigator: root).popUntil((route) => route.isFirst);

Future<T> navigate<T extends Object>(BuildContext context, Widget targetPage, {bool root = false}) {
  final Route<T> route = Platform.isIOS ? CupertinoPageRoute(builder: (context) => targetPage) : MaterialPageRoute(builder: (context) => targetPage);
  return Navigator.of(context, rootNavigator: root).push(route);
}

Future<T> navigateFinish<T extends Object>(BuildContext context, Widget targetPage) {
  final Route<T> route = Platform.isIOS ? CupertinoPageRoute(builder: (context) => targetPage) : MaterialPageRoute(builder: (context) => targetPage);
  return Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(route, (route) => false);
}

//========
// Styles
//========
TextStyle getButtonTextStyle(BuildContext context) => Platform.isIOS ? CupertinoTheme.of(context).textTheme.actionTextStyle : Theme.of(context).textTheme.button;

Color getColor(BuildContext context, ColorType type) {
  bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

  switch (type) {
    case ColorType.PRIMARY:
      return isDarkMode ? PRIMARY_COLOR_DARK : PRIMARY_COLOR;
    case ColorType.SLIVER:
      return isDarkMode ? SLIVER_COLOR_DARK : SLIVER_COLOR;
    case ColorType.ACCENT:
      return isDarkMode ? ACCENT_COLOR_DARK : ACCENT_COLOR;
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
    case ColorType.BUTTON_TEXT:
      return isDarkMode ? TEXT_COLOR : TEXT_COLOR_DARK;
    case ColorType.BAR:
      return isDarkMode ? BAR_COLOR_DARK : BAR_COLOR;
    case ColorType.LIST:
      return Platform.isIOS ? getColor(context, ColorType.CARD) : Colors.transparent;
    default:
      return isDarkMode ? PRIMARY_COLOR_DARK : PRIMARY_COLOR;
  }
}

void fixNavigationBarColor(BuildContext context) {
  bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
  SystemUiOverlayStyle style = isDarkMode ? SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: PRIMARY_COLOR_DARK) : SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: PRIMARY_COLOR);
  SystemChrome.setSystemUIOverlayStyle(style);
}
