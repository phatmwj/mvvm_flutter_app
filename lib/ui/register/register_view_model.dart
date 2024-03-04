import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../repository/Repository.dart';

class RegisterViewModel extends ChangeNotifier{
  final _repo = Repository();

  late String _fullName;
  late String _phoneNumber;
  late String _password;
  late String _confirmPassword;

  String get fullName => _fullName;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }


  setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

}