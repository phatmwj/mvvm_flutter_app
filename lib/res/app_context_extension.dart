import 'package:flutter/cupertino.dart';

import 'resources.dart';

extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}

