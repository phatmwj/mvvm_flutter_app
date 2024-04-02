import 'package:flutter/cupertino.dart';
import '../res/strings/bangla_strings.dart';
import '../res/strings/strings.dart';

import 'colors/app_colors.dart';
import 'dimentions/app_dimension.dart';
import 'strings/english_strings.dart';

class Resources {

  final BuildContext _context;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'bn':
        return BanglaStrings();
      default:
        return EnglishStrings();
    }
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }

}