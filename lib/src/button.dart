import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';
import 'external/cupertino_list_tile.dart';

EdgeInsetsGeometry get _standardButtonMargin => EdgeInsets.symmetric(vertical: DEFAULT_MARGIN * 0.5, horizontal: DEFAULT_MARGIN);
EdgeInsetsGeometry get _standardButtonPadding => EdgeInsets.symmetric(vertical: DEFAULT_MARGIN, horizontal: DEFAULT_MARGIN * 3);
TextStyle _getTextStyle(BuildContext context, {bool google = false}) => getButtonTextStyle(context).copyWith(color: getColor(context, google ? ColorType.TEXT : ColorType.BUTTON_TEXT));

class AButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color buttonColor;
  final Function() onPressed;
  AButton({@required this.label, this.icon, this.iconColor, this.buttonColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Widget child = Row(children: [
      if (icon != null) Padding(padding: EdgeInsets.only(right: DEFAULT_MARGIN), child: AnIcon(icon, button: true, color: iconColor)),
      Expanded(child: AText(label, textAlign: TextAlign.center, maxLines: 1, style: _getTextStyle(context))),
    ]);

    Widget buttonWidget;

    if (Platform.isIOS) {
      buttonWidget = CupertinoButton(padding: _standardButtonPadding, child: child, onPressed: onPressed, color: buttonColor ?? CupertinoTheme.of(context).primaryColor);
    } else {
      buttonWidget = RaisedButton(padding: _standardButtonPadding, child: child, onPressed: onPressed, color: buttonColor);
    }

    return Container(margin: _standardButtonMargin, child: buttonWidget);
  }
}

class AGoogleSignInButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  AGoogleSignInButton({@required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Widget child = Row(children: [
      Padding(padding: EdgeInsets.only(right: DEFAULT_MARGIN), child: AnImageIcon("assets/google.png")),
      Expanded(child: AText(label, textAlign: TextAlign.center, maxLines: 1, style: _getTextStyle(context, google: true))),
    ]);

    final Color buttonColor = getColor(context, ColorType.CARD);
    Widget buttonWidget;

    if (Platform.isIOS) {
      buttonWidget = CupertinoButton(padding: _standardButtonPadding, child: child, onPressed: onPressed, color: buttonColor);
    } else {
      buttonWidget = RaisedButton(padding: _standardButtonPadding, child: child, onPressed: onPressed, color: buttonColor);
    }

    return Container(margin: _standardButtonMargin, child: buttonWidget);
  }
}

class AVerticalButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color buttonColor;
  final Function() onPressed;
  AVerticalButton({@required this.label, this.icon, this.iconColor, this.buttonColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Widget child = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (icon != null) Padding(padding: EdgeInsets.only(bottom: DEFAULT_MARGIN), child: AnIcon(icon, button: true, color: iconColor)),
      AText(label, textAlign: TextAlign.center, maxLines: 2, style: _getTextStyle(context)),
    ]);

    final EdgeInsetsGeometry margin = EdgeInsets.symmetric(vertical: DEFAULT_MARGIN * 0.5, horizontal: DEFAULT_MARGIN * 0.5);
    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(vertical: DEFAULT_MARGIN, horizontal: DEFAULT_MARGIN);
    Widget buttonWidget;

    if (Platform.isIOS) {
      buttonWidget = CupertinoButton(padding: padding, child: child, onPressed: onPressed, color: buttonColor ?? CupertinoTheme.of(context).primaryColor);
    } else {
      buttonWidget = RaisedButton(padding: padding, child: child, onPressed: onPressed, color: buttonColor);
    }

    return Container(margin: margin, child: buttonWidget);
  }
}

class ATextButton extends StatelessWidget {
  final String label;
  final TextStyle style;
  final bool negative;
  final Function() onPressed;
  ATextButton({@required this.label, this.style, this.negative = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color color = getColor(context, negative ? ColorType.NEGATIVE : ColorType.ACCENT);
    TextStyle textStyle = Platform.isIOS ? CupertinoTheme.of(context).textTheme.actionTextStyle : Theme.of(context).textTheme.button;
    textStyle = textStyle.merge(style).copyWith(color: color);
    final Widget child = AText(label, textAlign: TextAlign.center, maxLines: 1, style: textStyle);
    final EdgeInsetsGeometry padding = EdgeInsets.zero;
    Widget buttonWidget;

    if (Platform.isIOS) {
      buttonWidget = CupertinoButton(padding: padding, child: child, onPressed: onPressed);
    } else {
      buttonWidget = FlatButton(padding: padding, child: child, onPressed: onPressed);
    }

    return Container(margin: padding, child: buttonWidget);
  }
}

class NegativeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onPressed;
  NegativeButton({@required this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AButton(label: label, icon: icon, onPressed: onPressed, buttonColor: getColor(context, ColorType.NEGATIVE));
  }
}

class AFloatingButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final String heroTag;
  final Color color;
  final Color iconColor;
  AFloatingButton({@required this.heroTag, this.icon, this.color, this.iconColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = onPressed != null ? color ?? getColor(context, ColorType.ACCENT) : getColor(context, ColorType.INACTIVE);
    final Color iconColor = onPressed != null ? this.iconColor : null;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: FloatingActionButton(
        child: AnIcon(icon, button: true, color: iconColor),
        heroTag: heroTag,
        backgroundColor: buttonColor,
        splashColor: Platform.isIOS ? Colors.transparent : null,
        onPressed: onPressed,
      ),
    );
  }
}

class AnIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  AnIconButton({@required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry padding = EdgeInsets.zero;
    final Color color = getColor(context, ColorType.ACCENT);
    final AnIcon child = AnIcon(icon, color: color);
    return Platform.isIOS ? CupertinoButton(padding: padding, child: child, onPressed: onPressed) : IconButton(padding: padding, icon: child, onPressed: onPressed);
  }
}

class AListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Function() onTap;
  final bool last;
  AListTile({this.leading, this.title, this.subtitle, this.trailing, this.onTap, this.last = false});

  @override
  Widget build(BuildContext context) {
    Widget _widget;

    if (Platform.isIOS) {
      _widget = CupertinoListTile(leading: leading, title: title, subtitle: subtitle, trailing: trailing, onTap: onTap, border: last ? Border() : null);
    } else {
      _widget = ListTile(leading: leading, title: title, subtitle: subtitle, trailing: trailing, onTap: onTap);
    }

    return _widget;
  }
}
