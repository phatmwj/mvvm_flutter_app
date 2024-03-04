
import 'package:flutter/widgets.dart';

import '../../data/local/prefs/AppPreferecesService.dart';
import '../../repository/Repository.dart';

class HomeViewModel extends ChangeNotifier{
  final _repo = Repository();
  final _prefs = AppPreferencesService();
}