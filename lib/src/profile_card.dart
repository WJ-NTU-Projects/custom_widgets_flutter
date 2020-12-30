import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets_wj.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String photo;
  final String role;
  ProfileCard({@required this.name, @required this.photo, @required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: DEFAULT_MARGIN * 2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
          child: Column(children: [
            CircleAvatar(backgroundImage: NetworkImage(photo), radius: DEFAULT_ICON_SIZE * 1.5, backgroundColor: Colors.transparent),
            SizedBox(height: DEFAULT_MARGIN),
            AText(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            SizedBox(height: DEFAULT_MARGIN * 0.25),
            AText(role, style: TextStyle(fontSize: 16)),
          ]),
        ),
        SizedBox(height: DEFAULT_MARGIN * 2),
      ]),
    );
  }
}
