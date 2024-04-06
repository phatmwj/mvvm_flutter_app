

import 'package:flutter/cupertino.dart';

import 'strings.dart';

class EnglishStrings extends Strings {

  final BuildContext context;

  static EnglishStrings? _instance;

  EnglishStrings(this.context);

  static EnglishStrings of(BuildContext context){
    _instance ??= EnglishStrings(context);
    return _instance!;
  }

  @override
  String get homeScreenTitle => "User List";

  @override
  String get detailScreenTitle => "User Details";

  @override
  String get labelName => "Name";

  @override
  String get labelNote => "Note";

  @override
  String get labelPhone => "Phone";

  @override
  String get labelId => "ID";

  @override
  String get labelLoading => "Loading";


}
