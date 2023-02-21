import 'package:flutter/material.dart';

class AppConfig {
  late BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  AppConfig(BuildContext _context) {
    this._context = _context;
    var _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;

    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding * v;
  }
}

class AppColors {
  Color appbarBackColor(double opacity) {
    try {
      return const Color(0xFF0E1823).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color drawerItemBackColor(double opacity) {
    try {
      return const Color(0xFF26405E).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color secondColor(double opacity) {
    try {
      return Colors.grey.shade500;
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color homeTitleColor(double opacity) {
    try {
      return const Color(0xFF6D7B8F).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color accentColor(double opacity) {
    try {
      return const Color(0xFF18489C);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorPrimary(double opacity) {
    try {
      return const Color(0xff0071BC);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorPrimaryLight(double opacity) {
    try {
      return Colors.grey;
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorPrimaryDark(double opacity) {
    try {
      return const Color(0xFF666666);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorDivider(double opacity) {
    try {
      return const Color(0xFF001757).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color textFieldBackgroundColor(double opacity) {
    try {
      return const Color(0xFFE9E9E9).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color hintTextBackgroundColor(double opacity) {
    try {
      return const Color(0xFFAEAEAE).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color scaffoldColor(double opacity) {
    // TODO test if brightness is dark or not
    try {
      // return  const Color(0xffeee6ff).withOpacity(1);
      return Colors.white;
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }
}

class FontFamily {
  static final FontFamily _singleton = FontFamily._internal();

  factory FontFamily() {
    return _singleton;
  }

  FontFamily._internal();

  String itcAvantGardeGothicStdFontFamily = "itc_avant_garde_gothic_std";
  FontWeight extraLight = FontWeight.w200;
  FontWeight book = FontWeight.w300;
  FontWeight medium = FontWeight.w500;
  FontWeight demi = FontWeight.w600;
  FontWeight bold = FontWeight.w700;
}
