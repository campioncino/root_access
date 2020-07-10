import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Provides a way to get root access.
class RootAccess {
  /// Channel used to communicate to native code.
  static const MethodChannel channel = const MethodChannel('root_access');

  /// Triggers app to get root access
  ///
  /// If device is not rooted then this will return `false`.
  /// Else it will open installed superuser or similar app's pop up asking for Permission.
  static Future<bool> get rootAccess async {
    if (Platform.isAndroid) {
      final bool isRootAccess = await channel.invokeMethod('isAccessGiven');
      return isRootAccess;
    }
    else{
      final bool isJailBroken = await channel.invokeMethod('isJailBroken');
      final bool isRealDevice = await channel.invokeMethod('isRealDevice');
      return isJailBroken || !isRealDevice;
    }
  }
  
  static Future<bool> get isRoot async {
    final bool access = await channel.invokeMethod('isAccessGiven');
    return access;
  }
  
  static Future<bool> get isRealDevice async {
    final bool isRealDevice = await channel.invokeMethod('isRealDevice');
    return isRealDevice;
  }
  
  static Future<bool> get isJailBroken async {
    final bool isJailBroken = await channel.invokeMethod('isJailBroken');
    return isJailBroken;
  }
  
}
