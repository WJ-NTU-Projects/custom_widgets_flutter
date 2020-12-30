import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManyIcons {
  static IconData tabNavigation = Platform.isIOS ? CupertinoIcons.location_fill : Icons.navigation;
  static IconData tabSteps = Icons.directions_walk;
  static IconData tabGroups = Platform.isIOS ? CupertinoIcons.group_solid : Icons.group;
  static IconData tabSettings = Platform.isIOS ? CupertinoIcons.settings_solid : Icons.settings;
  static IconData checkCircled = Platform.isIOS ? CupertinoIcons.checkmark_circle_fill : Icons.check_circle;
  static IconData exclamationTriangle = Platform.isIOS ? CupertinoIcons.exclamationmark_triangle_fill : Icons.warning;
  static IconData person = Platform.isIOS ? CupertinoIcons.person_solid : Icons.person;
  static IconData clock = Platform.isIOS ? CupertinoIcons.clock : Icons.access_time;
  static IconData location = Platform.isIOS ? CupertinoIcons.location_solid : Icons.location_on;
  static IconData navigation = Platform.isIOS ? CupertinoIcons.location_north_fill : Icons.navigation;
  static IconData next = Platform.isIOS ? CupertinoIcons.right_chevron : Icons.chevron_right;
  static IconData profile = Platform.isIOS ? CupertinoIcons.profile_circled : Icons.account_circle;
  static IconData search = Platform.isIOS ? CupertinoIcons.search : Icons.search;
}
