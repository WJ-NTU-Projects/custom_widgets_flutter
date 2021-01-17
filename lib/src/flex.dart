import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AColumn extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment alignment;
  final MainAxisSize size;
  AColumn(this.children, {this.alignment = CrossAxisAlignment.start, this.size = MainAxisSize.min});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: size, crossAxisAlignment: alignment, children: children);
  }
}
