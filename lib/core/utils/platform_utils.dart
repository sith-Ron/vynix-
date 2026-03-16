import 'package:flutter/material.dart';

abstract final class PlatformUtils {
  static bool isCupertino(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  static ScrollPhysics defaultScrollPhysics(BuildContext context) {
    return isCupertino(context)
        ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
        : const ClampingScrollPhysics();
  }
}
