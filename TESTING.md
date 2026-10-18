# 🧪 Testing Guide

## Unit Testing

### Setup
```bash
flutter pub add dev:flutter_test
```

### Example Test File
```dart
// test/models/user_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:maharashtra_teacher/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('User.fromJson creates user correctly', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'name': 'Test User',
        'verified': true,
        'created_at': '2026-10-18T00:00:00Z',
      };
      
      final user = User.fromJson(json);
      
      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.verified, true);
    });

    test('User.toJson converts user to JSON', () {
      final user = User(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        verified: true,
        createdAt: DateTime(2026, 10, 18),
      );
      
      final json = user.toJson();
      
      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
    });
  });
}
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific file
flutter test test/models/user_test.dart

# Run with pattern
flutter test --name "User Model"

# Run with coverage
flutter test --coverage
```

---

## Widget Testing

### Example Widget Test
```dart
// test/widgets/post_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maharashtra_teacher/models/post.dart';
import 'package:maharashtra_teacher/widgets/post_card.dart';

void main() {
  group('PostCard Widget Tests', () {
    testWidgets('PostCard displays post title', (WidgetTester tester) async {
      final post = Post(
        id: 1,
        title: 'Test Post',
        content: 'Test Content',
        userId: '123',
        userName: 'Test User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PostCard(post: post, onDelete: () {}),
          ),
        ),
      );

      expect(find.text('Test Post'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('PostCard delete button works', (WidgetTester tester) async {
      bool deleted = false;
      final post = Post(
        id: 1,
        title: 'Test',
        content: 'Content',
        userId: '123',
        userName: 'User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PostCard(
              post: post,
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      // Tap delete menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Confirm delete dialog
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(deleted, true);
    });
  });
}
```

### Running Widget Tests
```bash
flutter test test/widgets/
```

---

## Integration Testing

### Setup
```bash
flutter pub add dev:integration_test
```

### Example Integration Test
```dart
// test/integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maharashtra_teacher/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('Complete user flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test signup
      await tester.tap(find.text("Don't have an account? Sign up"));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).at(0),
        'test@example.com',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        'Test User',
      );
      await tester.enterText(
        find.byType(TextField).at(2),
        'Password123!',
      );

      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();

      // Check if logged in
      expect(find.text('Feed'), findsOneWidget);

      // Test post creation
      await tester.tap(find.text('Create Post'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byHint('Post title...'), 'Test Post');
      await tester.enterText(find.byHint('Write your post...'), 'Test Content');

      await tester.tap(find.text('Post'));
      await tester.pumpAndSettle();

      // Verify post appears
      expect(find.text('Test Post'), findsOneWidget);
    });
  });
}
```

### Running Integration Tests
```bash
# On Android emulator
flutter test test/integration_test/app_test.dart

# On iOS simulator
flutter test test/integration_test/app_test.dart -d all
```

---

## Manual Testing Checklist

### Authentication
- [ ] Sign up with valid email
- [ ] Sign up with invalid email (should fail)
- [ ] Sign up with weak password (should fail)
- [ ] Login with correct credentials
- [ ] Login with incorrect credentials (should fail)
- [ ] Logout successfully
- [ ] Session persists after app restart

### Posts
- [ ] Create post with title and content
- [ ] Create post with empty title (should fail)
- [ ] View all posts in feed
- [ ] Delete own post
- [ ] Cannot delete others' posts
- [ ] Posts appear in real-time
- [ ] Long posts truncate properly

### Directory
- [ ] View all verified teachers
- [ ] Search by name
- [ ] Search by district
- [ ] Search returns empty when no matches
- [ ] Click teacher shows details
- [ ] Pagination works (if implemented)

### Profile
- [ ] View own profile
- [ ] Edit profile fields
- [ ] Save profile changes
- [ ] Changes persist after reload
- [ ] Logout from profile
- [ ] Avatar displays correctly

### UI/UX
- [ ] Responsive on phone (portrait & landscape)
- [ ] Responsive on tablet
- [ ] Dark mode works
- [ ] All buttons clickable
- [ ] Loading indicators show
- [ ] Error messages appear
- [ ] No layout issues
- [ ] Smooth animations

### Performance
- [ ] App starts in < 3 seconds
- [ ] Posts load in < 2 seconds
- [ ] Search is responsive
- [ ] No lag when scrolling
- [ ] Memory usage stable
- [ ] Battery usage acceptable
- [ ] No crashes

### Network
- [ ] Works on WiFi
- [ ] Works on mobile data
- [ ] Graceful offline handling
- [ ] Syncs when back online
- [ ] Handles slow network (3G)
- [ ] Handles connection loss

### Security
- [ ] Password field is masked
- [ ] Logout clears session
- [ ] Session expires after inactivity
- [ ] No sensitive data in logs
- [ ] API calls use HTTPS
- [ ] Validation on all inputs

---

## Test Coverage

### View Coverage Report
```bash
# Generate coverage
flutter test --coverage

# View report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Target Coverage
- **Models**: 100% (critical data)
- **Services**: 80%+ (business logic)
- **Screens**: 40%+ (UI is harder to test)
- **Widgets**: 60%+ (reusable components)
- **Overall**: 70%+

---

## CI/CD Testing

Tests automatically run on:
- Every push to `main`
- Every pull request
- GitHub Actions workflow: `.github/workflows/flutter_test.yml`

View results:
1. Go to GitHub repository
2. Click "Actions" tab
3. Select workflow run
4. View test output

---

## Performance Testing

### Build Size
```bash
flutter build apk --analyze-size --release
flutter build appbundle --analyze-size --release
```

### Frame Rate
```dart
// In main.dart for development
void main() {
  debugPrintBeginFrameBanner = true;
  debugPrintEndFrameBanner = true;
  runApp(const MyApp());
}
```

Then enable debug overlay in app (Toggle with 'P' key).

### Memory Usage
```bash
# Android
adb shell dumpsys meminfo com.maharashtra.teacher

# iOS
Xcode → Debug → Memory Report
```

---

## Bug Reporting

Found a bug? Report it:

1. **Create GitHub Issue** with:
   - Title: Clear, concise
   - Description: What happened, expected vs actual
   - Steps to reproduce: Exact steps
   - Device/OS: Where it occurred
   - Screenshots: Visual evidence
   - Logs: Error messages

2. **Example Bug Report**:
   ```
   Title: Posts don't load on slow network
   
   Description: When using 3G network, posts take > 10 seconds to load
   
   Steps to Reproduce:
   1. Connect to 3G network
   2. Open app
   3. Navigate to Feed
   
   Expected: Posts load within 2 seconds
   Actual: Posts take 10+ seconds or timeout
   
   Device: Pixel 5, Android 12
   Network: 3G (3 Mbps)
   
   [Screenshot of loading screen]
   ```

---

## Test Data

### Sample User
- Email: `test@example.com`
- Password: `TestPassword123`

### Sample Posts
- Title: "Flutter Tips"
- Content: "Here are some useful Flutter tips..."

### Sample Teachers
- Name: "Rajesh Kumar"
- District: "Pune"
- Experience: 5 years

---

## Troubleshooting

### Tests Won't Run
```bash
flutter clean
flutter pub get
flutter test
```

### Widget Test Fails
- Ensure widget is wrapped in MaterialApp
- Use `pumpAndSettle()` for async operations
- Check find conditions are correct

### Integration Test Hangs
- Increase timeout with `--test-randomize-ordering-seed=0`
- Check emulator is responsive
- View logs: `flutter test -v test/integration_test/app_test.dart`

### Coverage Report Issues
```bash
# Install lcov
brew install lcov  # macOS
apt-get install lcov  # Linux

# Generate and view
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Resources

- [Flutter Testing Docs](https://flutter.dev/docs/testing)
- [Dart Testing Guide](https://dart.dev/guides/testing)
- [Widget Testing](https://flutter.dev/docs/testing/widgets-test)
- [Integration Testing](https://flutter.dev/docs/testing/integration-tests)

---

**Last Updated**: October 18, 2026  
**Maintained By**: QA Team
