import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';

class ModalTextField extends StatefulWidget {
  final TextEditingController editingController;
  final String title;
  final String hint;
  final String placeholder;
  final TextInputType inputType;
  final int limit;
  final String buttonLabel;
  final IconData buttonIcon;
  final Function() onSubmit;

  ModalTextField({
    @required this.editingController,
    @required this.title,
    @required this.placeholder,
    @required this.hint,
    @required this.inputType,
    @required this.limit,
    @required this.buttonLabel,
    @required this.buttonIcon,
    @required this.onSubmit,
  });

  @override
  _ModalTextFieldState createState() => _ModalTextFieldState();
}

class _ModalTextFieldState extends State<ModalTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.editingController;
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(vertical: DEFAULT_MARGIN * 0.75, horizontal: DEFAULT_MARGIN * 0.5);
    Widget textField;

    if (Platform.isIOS) {
      textField = CupertinoTextField(padding: padding, controller: _controller, placeholder: widget.placeholder, maxLength: widget.limit, keyboardType: widget.inputType, textCapitalization: TextCapitalization.words);
    } else {
      final InputDecoration decoration = InputDecoration(contentPadding: padding, hintText: widget.placeholder);
      textField = TextField(decoration: decoration, controller: _controller, maxLength: widget.limit, keyboardType: widget.inputType, textCapitalization: TextCapitalization.words);
    }

    final Radius borderRadius = Radius.circular(DEFAULT_MARGIN * 2);

    return Container(
      decoration: BoxDecoration(color: getColor(context, ColorType.CARD), borderRadius: BorderRadius.only(topLeft: borderRadius, topRight: borderRadius)),
      padding: EdgeInsets.symmetric(vertical: DEFAULT_MARGIN * 2, horizontal: DEFAULT_MARGIN * 2),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        AText(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        SizedBox(height: DEFAULT_MARGIN * 2),
        textField,
        SizedBox(height: DEFAULT_MARGIN * 0.5),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: AText(widget.hint, style: TextStyle(color: CAPTION_COLOR, fontSize: 14))),
        SizedBox(height: DEFAULT_MARGIN),
        AButton(icon: widget.buttonIcon, label: widget.buttonLabel, onPressed: widget.onSubmit),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ]),
    );
  }
}
