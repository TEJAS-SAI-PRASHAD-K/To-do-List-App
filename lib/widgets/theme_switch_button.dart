import 'package:first_1_flutter_application/theme/theme.dart';
import 'package:first_1_flutter_application/utils/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return IconButton(
        onPressed: () {
          if (theme == lightTheme) {
            ref.read(themeProvider.notifier).state = darkTheme;
          } else {
            ref.read(themeProvider.notifier).state = lightTheme;
          }
        },
        icon: theme == lightTheme
            ? const Icon(Icons.light_mode_rounded)
            : const Icon(Icons.dark_mode_rounded));
  }
}
