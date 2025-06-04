import 'package:demo/pages/operators_modules/shift_page.dart';
import 'package:demo/pages/widget_modules/banner_page.dart';
import 'package:demo/pages/widget_modules/cupertino_page.dart';
import 'package:demo/pages/widget_modules/cut_page.dart';
import 'package:demo/pages/widget_modules/drag_page.dart';
import 'package:demo/pages/home_page.dart';
import 'package:demo/routes/routes_name.dart';
import 'package:flutter/widgets.dart';

abstract class RoutesPages {
  static Map<String, WidgetBuilder> get pages => {
    RoutesNames.home: (context) => HomePage(),
    RoutesNames.dragPage: (context) => DragPage(),
    RoutesNames.cutPage: (context) => CutPage(),
    RoutesNames.shiftPage: (context) => ShiftPage(),
    RoutesNames.bannerPage: (context) => BannerPage(),
    RoutesNames.enumCupertinoPage: (context) => CupertinoPage(),
  };
}
