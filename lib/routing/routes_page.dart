import 'package:demo/pages/operators_modules/shift_page.dart';
import 'package:demo/pages/widget_modules/banner_page.dart';
import 'package:demo/pages/widget_modules/cupertino_page.dart';
import 'package:demo/pages/widget_modules/cut_page.dart';
import 'package:demo/pages/home_page.dart';
import 'package:demo/routing/routes_name.dart';
import 'package:demo/ui/drag_module/widgets/drag_screen.dart';
import 'package:demo/ui/from_module/widgets/from_screen.dart';
import 'package:flutter/widgets.dart';

abstract class RoutesPages {
  static Map<String, WidgetBuilder> get pages => {
    RoutesNames.home: (context) => HomePage(),
    RoutesNames.dragPage: (context) => DragPage(),
    RoutesNames.cutPage: (context) => CutPage(),
    RoutesNames.shiftPage: (context) => ShiftPage(),
    RoutesNames.bannerPage: (context) => BannerPage(),
    RoutesNames.enumCupertinoPage: (context) => CupertinoPage(),
    RoutesNames.formPage: (context) => FormPage(),
  };
}
