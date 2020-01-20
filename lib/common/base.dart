import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Base {
  static w(num width) {
    return ScreenUtil.getInstance().setWidth(width);
  }

  static h(num height) => ScreenUtil.getInstance().setHeight(height);

  static f(num fontSize) => ScreenUtil.getInstance().setSp(fontSize);
}