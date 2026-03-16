import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveSectionScaffold extends StatelessWidget {
  const AdaptiveSectionScaffold({
    super.key,
    required this.title,
    required this.body,
    this.trailing,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final Widget? trailing;
  final Widget? floatingActionButton;

  bool get _isCupertino {
    if (kIsWeb) {
      return false;
    }
    return Platform.isIOS || Platform.isMacOS;
  }

  @override
  Widget build(BuildContext context) {
    if (_isCupertino) {
      final pageBody = SafeArea(
        bottom: false,
        child: Material(type: MaterialType.transparency, child: body),
      );

      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
          trailing: trailing,
        ),
        child: floatingActionButton == null
            ? pageBody
            : Stack(
                children: [
                  pageBody,
                  PositionedDirectional(
                    end: 16,
                    bottom: 16,
                    child: SafeArea(top: false, child: floatingActionButton!),
                  ),
                ],
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: trailing == null ? null : [trailing!],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
