import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/core/providers/app_settings_provider.dart';
import 'package:vynix/core/theme/vynix_theme.dart';
import 'package:vynix/features/home/presentation/pages/home_shell_page.dart';

class VynixApp extends ConsumerWidget {
  const VynixApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsControllerProvider);

    return MaterialApp(
      title: 'Vynix',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: VynixTheme.light(),
      darkTheme: VynixTheme.dark(),
      locale: settings.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: FlutterQuillLocalizations.supportedLocales,
      home: const HomeShellPage(),
      scrollBehavior: const CupertinoScrollBehavior(),
      builder: (context, child) {
        // Enforce iOS bounce and Android clamping at app level.
        final platform = Theme.of(context).platform;
        final physics = platform == TargetPlatform.iOS
            ? const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              )
            : const ClampingScrollPhysics();

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(physics: physics),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: child,
          ),
        );
      },
    );
  }
}
