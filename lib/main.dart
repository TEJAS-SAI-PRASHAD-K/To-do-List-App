import 'package:first_1_flutter_application/models/hive_adapters.dart';
import 'package:first_1_flutter_application/models/user.dart';
import 'package:first_1_flutter_application/pages/bottom_nav_bar.dart';
import 'package:first_1_flutter_application/theme/theme.dart';
import 'package:first_1_flutter_application/utils/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'models/task.dart';
// import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerHiveAdapters();
  await Hive.openBox<User>('todoTasks');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const BottomNavBar(),
    );
  }
}
