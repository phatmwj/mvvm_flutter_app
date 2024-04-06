import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/res/colors/base_colors.dart';
import 'package:mvvm_flutter_app/res/dimentions/dimensions.dart';
import '../res/strings/bangla_strings.dart';
import '../res/strings/strings.dart';

import 'colors/app_colors.dart';
import 'dimentions/app_dimension.dart';
import 'strings/english_strings.dart';

class Resources {

  final BuildContext _context;

  static Resources? _instance;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'bn':
        return BanglaStrings.of(_context);
      default:
        return EnglishStrings.of(_context);
    }
  }

  BaseColors get color {
    return AppColors.of(_context);
  }

  Dimensions get dimension {
    return AppDimension.of(_context);
  }

  static Resources of(BuildContext context){
    _instance ??= Resources(context);
    return _instance!;
  }

}