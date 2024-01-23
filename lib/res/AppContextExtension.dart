import 'package:flutter/cupertino.dart';

import 'Resources.dart';

extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}

