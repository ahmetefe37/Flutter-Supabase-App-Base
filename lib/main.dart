import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/app_config.dart';
import 'core/config/app_router.dart';
import 'core/services/supabase_service.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('⚠️ Environment file not found or could not be loaded: $e');
  }

  // Check if configuration is valid
  if (!AppConfig.isConfigValid) {
    debugPrint('❌ Invalid configuration. Please check your .env file');
    debugPrint('Required: SUPABASE_URL, SUPABASE_ANON_KEY');
  }

  // Initialize services
  await _initializeServices();

  // Run the app
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initializeServices() async {
  try {
    // Initialize storage service
    await StorageService.instance.init();
    debugPrint('✅ Storage service initialized');

    // Initialize Supabase
    await SupabaseService.initialize();
    debugPrint('✅ Supabase initialized');
  } catch (e) {
    debugPrint('❌ Service initialization failed: $e');
    // You might want to show an error screen here
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Router Configuration
      routerConfig: router,

      // App Configuration
      builder: (context, child) {
        return MediaQuery(
          // Ensure text scale factor doesn't exceed reasonable limits
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
