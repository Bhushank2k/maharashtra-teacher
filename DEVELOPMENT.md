# 👨‍💻 Development Guide

## Environment Setup

### Prerequisites
- Flutter SDK 3.0+ ([install](https://flutter.dev/docs/get-started/install))
- Android SDK or Xcode
- VS Code or Android Studio
- Git

### First-Time Setup
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/maharashtra-teacher.git
cd maharashtra-teacher

# Install dependencies
flutter pub get

# Get Supabase credentials and update lib/main.dart
# Then run:
flutter run
```

---

## Project Structure

```
lib/
├── main.dart                 # App entry point, Supabase init
├── models/                   # Data classes
│   ├── user.dart            # User model
│   ├── post.dart            # Post model
│   └── comment.dart         # Comment model
├── services/                 # Business logic
│   └── supabase_service.dart # Database operations
├── screens/                  # UI pages
│   ├── auth_screen.dart     # Login/Signup
│   ├── home_screen.dart     # Main navigation
│   ├── posts_screen.dart    # Feed
│   ├── directory_screen.dart # Teachers
│   └── profile_screen.dart  # User profile
└── widgets/                  # Reusable components
    ├── post_card.dart       # Post display
    └── user_card.dart       # Teacher card
```

---

## Development Workflow

### 1. Create a Feature Branch
```bash
git checkout -b feature/feature-name
# or
git checkout -b bugfix/bug-name
```

### 2. Code Changes
- Follow Flutter style guide
- Use `flutter format .` for formatting
- Run `flutter analyze` before committing

### 3. Run & Test Locally
```bash
# Run in debug mode
flutter run

# Run on specific device
flutter run -d chrome     # Web
flutter run -d emulator-5555  # Android
flutter run -d iphone     # iOS simulator

# Build release
flutter build apk --release
flutter build ipa --release
flutter build web --release
```

### 4. Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/user_test.dart

# Run with coverage
flutter test --coverage
```

### 5. Code Quality
```bash
# Analyze code
flutter analyze

# Format code
flutter format .

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

### 6. Commit & Push
```bash
git add .
git commit -m "feat: description of changes"
git push origin feature/feature-name
```

### 7. Create Pull Request
- Go to GitHub
- Create PR from your branch
- Add description and tests
- Request review
- Wait for CI/CD to pass

---

## Important Files to Know

### Configuration Files
- **pubspec.yaml** - Dependencies and app metadata
- **analysis_options.yaml** - Linter rules
- **.gitignore** - Ignored files
- **database_schema.sql** - Database structure
- **android/build.gradle** - Android build config
- **ios/Podfile** - iOS dependencies

### Supabase Configuration
- Update `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `lib/main.dart`
- Database schema in `database_schema.sql`
- Row-level security policies in Supabase dashboard

### Environment Variables
Create `.env` file (git ignored):
```
SUPABASE_URL=your_url
SUPABASE_ANON_KEY=your_key
```

Then load in main.dart:
```dart
// TODO: Implement dotenv loading
```

---

## Common Development Tasks

### Adding a New Model
1. Create file in `lib/models/new_model.dart`
2. Define class with properties
3. Add `fromJson()` factory
4. Add `toJson()` method

Example:
```dart
class Post {
  final int id;
  final String title;
  
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}
```

### Adding a Database Table
1. Add SQL to `database_schema.sql`
2. Run in Supabase SQL Editor
3. Create model class
4. Add CRUD methods to `supabase_service.dart`

### Adding a New Screen
1. Create `lib/screens/new_screen.dart`
2. Extend `StatefulWidget` or `StatelessWidget`
3. Add to navigation in `home_screen.dart`
4. Add route if needed in `main.dart`

### Adding a Feature
1. Plan database changes
2. Update schema and deploy
3. Create models
4. Add service methods
5. Create UI screens
6. Test thoroughly
7. Create PR

---

## Debugging Tips

### Print Debugging
```dart
print('Debug: $variable');
debugPrint('Debug print in Flutter');
```

### Hot Reload vs Hot Restart
```bash
# Hot reload (faster, saves state)
r

# Hot restart (slower, resets state)
R

# Full rebuild
flutter run --no-fast-start
```

### Check Flutter Status
```bash
flutter doctor
```

### Emulator Issues
```bash
# List emulators
flutter emulators

# Launch emulator
flutter emulators --launch emulator_name

# Kill all emulators
adb kill-server
```

### Database Issues
1. Check Supabase dashboard
2. View logs: Dashboard → Logs
3. Check RLS policies
4. Verify table structure
5. Test queries in SQL Editor

---

## Code Standards

### Naming Conventions
- Classes: `PascalCase` (User, PostCard)
- Functions/variables: `camelCase` (getUserById, userName)
- Constants: `SCREAMING_SNAKE_CASE` (MAX_LENGTH)
- Files: `snake_case` (user.dart, post_card.dart)

### Comment Style
```dart
// Single line comment
/// Documentation comment for public APIs
/* Multi-line comment */
```

### Error Handling
```dart
try {
  final data = await SupabaseService.getData();
} catch (e) {
  print('Error: $e');
  // Show error to user
}
```

### Code Organization
```dart
// 1. Imports
import 'package:flutter/material.dart';

// 2. Class declaration
class MyWidget extends StatefulWidget {
  // 3. Properties
  final String title;
  
  // 4. Constructor
  const MyWidget({required this.title});
  
  // 5. Methods
  @override
  State createState() => _MyWidgetState();
}
```

---

## Performance Tips

1. **Use const** where possible
2. **Lazy load** images and lists
3. **Avoid rebuilds** with ValueNotifier
4. **Use ListView.builder** instead of Column
5. **Index database** queries properly
6. **Compress images** before upload
7. **Cache data** locally with Hive
8. **Limit RLS** policies for performance

---

## Security Best Practices

1. **Never hardcode** secrets
2. **Validate input** before saving
3. **Use HTTPS** only
4. **Enable RLS** on all tables
5. **Limit query** results
6. **Hash passwords** (Supabase does this)
7. **Encrypt sensitive** data
8. **Rate limit** API calls
9. **Log errors** securely
10. **Update dependencies** regularly

---

## Deployment Checklist

Before deploying:
- [ ] All tests pass
- [ ] No console warnings
- [ ] Code formatted
- [ ] Screenshots updated
- [ ] Version bumped
- [ ] Release notes written
- [ ] Dependencies updated
- [ ] Secrets secured
- [ ] Performance optimized
- [ ] Battery usage checked

---

## Useful Commands

```bash
# Build commands
flutter build apk --release          # Android APK
flutter build appbundle --release    # Android App Bundle
flutter build ipa --release          # iOS
flutter build web --release          # Web

# Development commands
flutter run                           # Debug run
flutter run -d all                    # All devices
flutter run --profile                 # Profile mode
flutter run --release                 # Release mode

# Testing
flutter test                          # All tests
flutter test --coverage               # With coverage
flutter test test/file_test.dart     # Specific test

# Cleaning
flutter clean                         # Clean build
rm -rf build/                         # Force clean
flutter pub get                       # Reinstall deps

# Analysis
flutter analyze                       # Run analyzer
flutter format .                      # Format code
flutter pub outdated                  # Check outdated deps
```

---

## Continuous Integration

We use GitHub Actions for CI/CD:
- Run tests on push/PR
- Check code analysis
- Build APK/IPA
- Run linters

View status: `.github/workflows/flutter_test.yml`

---

## Getting Help

1. **Check logs**: Run `flutter doctor`
2. **Search issues**: GitHub Issues
3. **Read docs**: [Flutter Docs](https://flutter.dev)
4. **Ask community**: Stack Overflow, Reddit
5. **Create issue**: If bug found

---

## Resources

- [Flutter Documentation](https://flutter.dev)
- [Dart Language](https://dart.dev)
- [Supabase Docs](https://supabase.com/docs)
- [Material Design](https://material.io/design)
- [Flutter Community](https://flutter.dev/community)

---

**Last Updated**: October 18, 2026  
**Maintained By**: Development Team
