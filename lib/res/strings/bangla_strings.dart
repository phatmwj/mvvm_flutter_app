
import 'package:flutter/cupertino.dart';

import 'strings.dart';

class BanglaStrings extends Strings {
  
  final BuildContext context;

  static BanglaStrings? _instance;

  BanglaStrings(this.context);

  static BanglaStrings of(BuildContext context){
    _instance ??= BanglaStrings(context);
    return _instance!;
  }
  
  @override
  String get homeScreenTitle => "ইউজারের তালিকা";

  @override
  String get detailScreenTitle => "ইউজারের বিস্তারিত";

  @override
  String get labelName => "নাম";

  @override
  String get labelNote => "নোট";

  @override
  String get labelPhone => "ফোন";

  @override
  String get labelId => "আইডি";

  @override
  String get labelLoading => "লোডিং";

}
