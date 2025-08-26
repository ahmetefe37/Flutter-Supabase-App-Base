# Supa Sample - Flutter + Supabase Base Template

A production-ready Flutter template with Supabase integration, designed to accelerate your app development. This template provides a solid foundation with authentication, navigation, state management, and modern UI components.

## 🌟 Features

- ✅ **Supabase Authentication** - Complete auth system with email/password
- ✅ **Modern UI/UX** - Material Design 3 based clean interface
- ✅ **State Management** - Robust state management with Riverpod
- ✅ **Navigation** - Modern routing with Go Router
- ✅ **Internationalization** - Multi-language support (EN, TR, ES, FR, DE)
- ✅ **Responsive Design** - Adaptive layouts for all screen sizes
- ✅ **File Management** - File upload/download with permission handling
- ✅ **Error Handling** - Comprehensive error management
- ✅ **Environment Config** - Secure configuration management
- ✅ **Type Safety** - Full TypeScript-level type safety with Dart
- ✅ **Clean Architecture** - Feature-based folder structure
- ✅ **Reusable Components** - Modular widget library

## 📋 Prerequisites

- Flutter 3.9 or higher
- Dart 3.0 or higher
- Supabase account
- Git
- VS Code or Android Studio (recommended)

## 📦 Key Dependencies

This template includes the following key packages:

**Core:**

- `supabase_flutter` - Supabase integration
- `flutter_riverpod` - State management
- `go_router` - Navigation
- `flutter_localizations` - Internationalization
- `flutter_dotenv` - Environment configuration

**UI & UX:**

- `shared_preferences` - Local storage
- `file_picker` - File selection
- `image_picker` - Camera/gallery access
- `permission_handler` - Device permissions

**Development:**

- `intl` - Internationalization utilities
- `path_provider` - File system paths

## 🚀 Quick Start

### 1. Use This Template

**Option A: GitHub Template**

```bash
# Click "Use this template" button on GitHub
# Clone your new repository
git clone https://github.com/your-username/your-new-project.git
cd your-new-project
```

**Option B: Manual Clone**

```bash
git clone https://github.com/your-username/supa_sample.git your-new-project
cd your-new-project
rm -rf .git
git init
git add .
git commit -m "Initial commit from supa_sample template"
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Setup

```bash
# Copy environment template
cp .env.example .env
```

Update `.env` with your Supabase credentials:

```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-from-supabase-dashboard
APP_ENV=development
```

### 4. Supabase Configuration

1. Create a new project at [Supabase](https://supabase.com)
2. Go to Project Settings > API
3. Copy your Project URL and anon/public key
4. Paste them into your `.env` file

> 📋 **For detailed Supabase setup instructions**, including database tables, RLS policies, and SQL commands, see [Supabase Setup Guide](supabase_setup.md)

### 5. Run the App

```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── core/                           # Core application logic
│   ├── config/                     # App configuration
│   │   ├── app_config.dart         # Environment variables
│   │   ├── app_router.dart         # Routing configuration
│   │   └── splash_screen.dart      # Initial loading screen
│   ├── constants/                  # Application constants
│   │   ├── app_constants.dart      # General constants
│   │   └── route_constants.dart    # Route definitions
│   ├── providers/                  # Global providers
│   │   └── localization_provider.dart # Language management
│   ├── services/                   # External services
│   │   ├── supabase_service.dart   # Supabase client wrapper
│   │   ├── storage_service.dart    # Local storage service
│   │   ├── localization_service.dart # Internationalization
│   │   ├── file_service.dart       # File operations
│   │   └── permission_service.dart # Device permissions
│   ├── theme/                      # UI theming
│   │   ├── app_colors.dart         # Color palette
│   │   └── app_theme.dart          # Theme configuration
│   └── utils/                      # Utility functions
│       ├── validators.dart         # Form validation
│       └── helpers.dart            # Helper functions
├── features/                       # Feature modules
│   ├── auth/                       # Authentication feature
│   │   ├── models/                 # Data models
│   │   │   ├── auth_state_model.dart
│   │   │   └── user_model.dart
│   │   ├── providers/              # State management
│   │   │   └── auth_provider.dart
│   │   ├── screens/                # UI screens
│   │   │   ├── forgot_password_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   └── widgets/                # Reusable widgets
│   │       ├── auth_button.dart
│   │       └── auth_text_field.dart
│   ├── home/                       # Home feature
│   │   └── screens/
│   │       └── home_screen.dart
│   └── profile/                    # Profile feature
│       └── screens/
│           └── profile_screen.dart
├── l10n/                          # Localization files
│   ├── app_en.arb                 # English translations
│   ├── app_tr.arb                 # Turkish translations
│   ├── app_es.arb                 # Spanish translations
│   ├── app_fr.arb                 # French translations
│   ├── app_de.arb                 # German translations
│   └── generated/                 # Auto-generated localization
├── shared/                         # Shared components
│   └── widgets/                    # Common widgets
│       ├── custom_app_bar.dart
│       ├── error_widget.dart
│       ├── loading_widget.dart
│       └── file_picker_widget.dart
└── main.dart                       # Application entry point
```

## 🛠️ Building Your Project on This Template

### Step 1: Customize App Identity

1. **Update App Name**

   ```dart
   // lib/core/config/app_config.dart
   static const String appName = 'Your App Name';
   ```

2. **Update Package Name**

   ```bash
   # Use flutter_flavorizr or manually update
   # android/app/build.gradle
   # ios/Runner/Info.plist
   ```

3. **App Icon & Splash Screen**
   ```bash
   # Add your app icon to assets/icon/app_icon.png
   flutter pub run flutter_launcher_icons:main
   ```

### Step 2: Add New Features

#### Creating a New Feature Module

1. **Create Feature Structure**

   ```bash
   mkdir -p lib/features/your_feature/{models,providers,screens,widgets}
   ```

2. **Create Model**

   ```dart
   // lib/features/your_feature/models/your_model.dart
   class YourModel {
     final String id;
     final String name;

     YourModel({required this.id, required this.name});

     factory YourModel.fromJson(Map<String, dynamic> json) {
       return YourModel(
         id: json['id'],
         name: json['name'],
       );
     }

     Map<String, dynamic> toJson() {
       return {'id': id, 'name': name};
     }
   }
   ```

3. **Create Provider**

   ```dart
   // lib/features/your_feature/providers/your_provider.dart
   import 'package:flutter_riverpod/flutter_riverpod.dart';

   class YourNotifier extends StateNotifier<List<YourModel>> {
     YourNotifier() : super([]);

     void addItem(YourModel item) {
       state = [...state, item];
     }
   }

   final yourProvider = StateNotifierProvider<YourNotifier, List<YourModel>>((ref) {
     return YourNotifier();
   });
   ```

4. **Create Screen**

   ```dart
   // lib/features/your_feature/screens/your_screen.dart
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';

   class YourScreen extends ConsumerWidget {
     const YourScreen({super.key});

     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final items = ref.watch(yourProvider);

       return Scaffold(
         appBar: AppBar(title: Text('Your Feature')),
         body: ListView.builder(
           itemCount: items.length,
           itemBuilder: (context, index) {
             return ListTile(title: Text(items[index].name));
           },
         ),
       );
     }
   }
   ```

5. **Add Route**
   ```dart
   // lib/core/config/app_router.dart
   GoRoute(
     path: '/your-feature',
     name: 'your-feature',
     builder: (context, state) => const YourScreen(),
   ),
   ```

### Step 3: Database Integration

> 📋 **For complete database setup**, see [Supabase Setup Guide](supabase_setup.md) which includes detailed SQL commands, RLS policies, and table structures.

#### Setting up Supabase Tables

1. **Create Table in Supabase**

   ```sql
   -- In Supabase SQL Editor
   CREATE TABLE your_table (
     id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
     user_id UUID REFERENCES auth.users(id),
     name TEXT NOT NULL,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
   );

   -- Enable RLS
   ALTER TABLE your_table ENABLE ROW LEVEL SECURITY;

   -- Create policy
   CREATE POLICY "Users can manage their own data" ON your_table
     FOR ALL USING (auth.uid() = user_id);
   ```

2. **Create Service**

   ```dart
   // lib/features/your_feature/services/your_service.dart
   import '../../../core/services/supabase_service.dart';

   class YourService {
     static final _supabase = SupabaseService.instance;

     static Future<List<Map<String, dynamic>>> getItems() async {
       final response = await _supabase.client
           .from('your_table')
           .select()
           .eq('user_id', _supabase.currentUser!.id);
       return response;
     }

     static Future<void> addItem(Map<String, dynamic> data) async {
       await _supabase.client
           .from('your_table')
           .insert({...data, 'user_id': _supabase.currentUser!.id});
     }
   }
   ```

### Step 4: Internationalization

This template includes built-in support for multiple languages:

#### Supported Languages

- 🇺🇸 English (en)
- 🇹🇷 Turkish (tr)
- 🇪🇸 Spanish (es)
- 🇫🇷 French (fr)
- 🇩🇪 German (de)

#### How to Use

1. **Language Selection**: Users can change language from the dropdown in the top-right corner of the home screen
2. **Automatic Detection**: The app automatically detects and uses the device's language if supported
3. **Persistent Storage**: Language preference is saved and restored on app restart

#### Adding New Languages

1. Create a new ARB file in `lib/l10n/` (e.g., `app_ja.arb` for Japanese)
2. Copy the structure from `app_en.arb` and translate the values
3. Add the new locale to `LocalizationService.supportedLocales`
4. Run `flutter gen-l10n` to generate the new translations
5. Update language selector UI if needed

#### Using Translations in Code

```dart
// In any widget
final l10n = AppLocalizations.of(context)!;
Text(l10n.welcome); // Shows translated welcome message
Text(l10n.greetingWithName.replaceAll('{name}', userName)); // With parameters
```

### Step 5: Advanced Features

#### Real-time Subscriptions

```dart
// lib/features/your_feature/providers/realtime_provider.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeNotifier extends StateNotifier<List<YourModel>> {
  late final RealtimeChannel _channel;

  RealtimeNotifier() : super([]) {
    _subscribeToChanges();
    _loadInitialData();
  }

  void _subscribeToChanges() {
    _channel = SupabaseService.instance.client
        .channel('your_table_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'your_table',
          callback: (payload) {
            _handleRealtimeEvent(payload);
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    _channel.unsubscribe();
    super.dispose();
  }
}
```

#### File Upload

```dart
// Upload file to Supabase Storage
Future<String> uploadFile(File file, String fileName) async {
  final bytes = await file.readAsBytes();
  final fileExt = fileName.split('.').last;
  final filePath = '${DateTime.now().toIso8601String()}.$fileExt';

  await SupabaseService.instance.client.storage
      .from('uploads')
      .uploadBinary(filePath, bytes);

  return SupabaseService.instance.client.storage
      .from('uploads')
      .getPublicUrl(filePath);
}
```

#### File Management

The template includes comprehensive file management:

```dart
// Pick image from gallery
final file = await FileService.instance.pickImageFromGallery();

// Pick image from camera
final file = await FileService.instance.pickImageFromCamera();

// Pick any file type
final file = await FileService.instance.pickFile();

// Handle permissions automatically
if (!await PermissionService.instance.requestStoragePermission()) {
  // Permission denied
}
```

## 🌐 Localization

### Supported Languages

- 🇺🇸 **English** (en-US) - Default
- 🇹🇷 **Turkish** (tr-TR)
- 🇪🇸 **Spanish** (es-ES)
- 🇫🇷 **French** (fr-FR)
- 🇩🇪 **German** (de-DE)

### Features

- **Dynamic Language Switching**: Change language without app restart
- **Device Language Detection**: Automatically uses device language if supported
- **Persistent Language Preference**: Remembers user's language choice
- **Live Preview**: Test all translations in the home screen
- **Type-Safe Translations**: Generated code with compile-time checks

### How It Works

1. ARB files in `lib/l10n/` contain translations
2. Flutter generates type-safe `AppLocalizations` class
3. Language selector in home screen allows instant switching
4. `LocalizationService` handles persistence and state management

````

## 🎨 Customizing UI

### Adding Custom Colors

```dart
// lib/core/theme/app_colors.dart
class AppColors {
  // Add your custom colors
  static const Color customPrimary = Color(0xFF6366F1);
  static const Color customSecondary = Color(0xFF06B6D4);
}
````

### Creating Custom Widgets

```dart
// lib/shared/widgets/custom_card.dart
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: padding ?? EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
```

## 🧪 Testing

### Setting Up Tests

```bash
# Create test files
mkdir -p test/{unit,widget,integration}
```

### Unit Test Example

```dart
// test/unit/auth_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('AuthProvider Tests', () {
    test('should initialize with unauthenticated state', () {
      final container = ProviderContainer();
      final authState = container.read(authProvider);

      expect(authState.isUnauthenticated, true);
    });
  });
}
```

## 🚀 Deployment

### Android

```bash
# Generate release APK
flutter build apk --release

# Generate App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Build for iOS
flutter build ios --release
```

### Web

```bash
# Build for web
flutter build web --release
```

## 📚 Best Practices

### 1. State Management

- Use Riverpod for all state management
- Keep providers focused and single-purpose
- Use proper state classes instead of primitives

### 2. Error Handling

- Always wrap async operations in try-catch
- Use custom exception classes
- Provide meaningful error messages to users

### 3. Performance

- Use const constructors where possible
- Implement proper list view builders for large datasets
- Cache network responses when appropriate

### 4. Security

- Never commit `.env` files
- Use Supabase RLS policies
- Validate all user inputs

## 🔧 Environment Management

### Development

```env
SUPABASE_URL=https://dev-project-id.supabase.co
SUPABASE_ANON_KEY=dev-anon-key
APP_ENV=development
```

### Production

```env
SUPABASE_URL=https://prod-project-id.supabase.co
SUPABASE_ANON_KEY=prod-anon-key
APP_ENV=production
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Supabase Team](https://supabase.com) for the backend-as-a-service platform
- [Riverpod](https://riverpod.dev) for state management
- [Go Router](https://pub.dev/packages/go_router) for navigation

---

**Happy Coding! 🚀**

Made with ❤️ by ahmet efe (https://github.com/ahmetefe37)
