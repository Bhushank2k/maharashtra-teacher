# 🚀 Complete Setup Instructions

## Phase 1: Supabase Setup (5 minutes)

### Step 1.1: Create Supabase Account
```
1. Open https://supabase.com
2. Click "Start your project"
3. Sign up with Email or GitHub
4. Create new organization: "Maharashtra Teacher"
5. Create new project: "maharashtra-teacher"
6. Select region: Europe (or closest to India)
7. Set secure password for database
8. Click "Create new project"
9. ⏳ Wait 2-3 minutes for initialization...
```

### Step 1.2: Get Your Credentials
```
1. Project is ready ✅
2. Click "Settings" → "API"
3. Copy "Project URL" (looks like: https://xxxxx.supabase.co)
4. Copy "Anon Key" (starts with eyJ...)
5. Save both in a text file - you'll need them soon!
```

### Step 1.3: Create Database Tables
```
1. In Supabase Dashboard, go to "SQL Editor"
2. Click "New Query"
3. Open file: database_schema.sql
4. Copy ALL the SQL code
5. Paste into Supabase SQL Editor
6. Click "Run"
7. ✅ Check "Table Editor" - you should see 4 tables:
   - users
   - posts
   - comments
   - resources
```

---

## Phase 2: Flutter Setup (10 minutes)

### Step 2.1: Install Flutter
```bash
# If not already installed:
# 1. Download from https://flutter.dev/docs/get-started/install
# 2. Extract to a folder
# 3. Add Flutter to PATH
# 4. Verify installation:
flutter --version
```

### Step 2.2: Clone/Extract Project
```bash
# If zip file:
unzip maharashtra_teacher.zip
cd maharashtra_teacher

# Or clone from git:
git clone <repo-url>
cd maharashtra_teacher
```

### Step 2.3: Update Supabase Credentials
```dart
# Open file: lib/main.dart
# Find these lines (around line 11):

await Supabase.initialize(
  url: 'PASTE_YOUR_PROJECT_URL_HERE',      // ← Replace with your URL
  anonKey: 'PASTE_YOUR_ANON_KEY_HERE',    // ← Replace with your key
);

# Example (your values will be different):
await Supabase.initialize(
  url: 'https://abcdefgh.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
);
```

### Step 2.4: Install Dependencies
```bash
flutter pub get
```

### Step 2.5: Get Emulator Ready
**Android:**
```bash
# Open Android Studio
# Tools → Device Manager
# Create new virtual device (Pixel 6, API 30+)
# Start the emulator
```

**iOS:**
```bash
# On macOS only:
open -a Simulator
# Or: Xcode → Tools → Simulator
```

**Web:**
```bash
# No setup needed, runs in Chrome
```

---

## Phase 3: Run the App (5 minutes)

### Step 3.1: Start the App
```bash
flutter run

# Choose your device:
# Press 'a' for Android emulator
# Press 'i' for iOS simulator
# Press 'c' for Chrome web
```

### Step 3.2: Test Features
```
1. ✅ App should load
2. Sign up with test account:
   - Email: test@example.com
   - Password: TestPassword123
   - Name: Your Name
3. ✅ Should see Feed screen
4. Create a post:
   - Title: "Hello World"
   - Content: "This is my first post!"
5. ✅ Post should appear in feed
6. Switch to "Teachers" tab
7. ✅ Should see teacher directory (empty if no users)
8. Switch to "Profile" tab
9. ✅ Should see your profile info
10. Edit profile and save
```

---

## Phase 4: Manual Testing

### Test Login Flow
```
1. Click "Already have account? Login"
2. Enter same email/password
3. ✅ Should login successfully
4. Should see previous posts
```

### Test Post Creation
```
1. Click "Create Post" button
2. Enter title and content
3. Click "Post"
4. ✅ Post should appear at top of feed
5. Click delete (⋯ menu)
6. ✅ Post should disappear
```

### Test Directory Search
```
1. Go to "Teachers" tab
2. Type in search box
3. ✅ Should filter results
4. Clear search
5. ✅ Should show all verified teachers
```

### Test Profile Edit
```
1. Go to "Profile" tab
2. Click "Edit Profile"
3. Change name, district, experience
4. Click "Save"
5. ✅ Changes should be saved
6. Refresh page - changes persist
```

---

## Phase 5: Next Steps

### Add More Features
See these files for adding features:
- `Advanced_Features_Guide.md` - Push notifications, search, ratings, etc.
- `12_Advanced_Features_Guide.md` - Implementation details

### Deploy to App Stores
See these files for deployment:
- `App_Store_Deployment.md` - Google Play & Apple App Store
- `13_App_Store_Deployment.md` - Complete deployment guide

### Scale the Backend
See these files for scaling:
- `Backend_Options_Comparison.md` - Compare backend technologies
- When you need: User verification, payments, custom features, admin panel

---

## ✅ Verification Checklist

```
Supabase Setup:
☐ Supabase account created
☐ Project created
☐ Credentials copied
☐ Database tables created (4 tables visible)
☐ SQL policies applied (RLS enabled)

Flutter Setup:
☐ Flutter installed
☐ Project extracted
☐ Credentials updated in main.dart
☐ Dependencies installed (flutter pub get)
☐ Emulator/device ready

App Testing:
☐ App runs without errors
☐ Sign up works
☐ Login works
☐ Can create posts
☐ Posts appear in feed
☐ Can delete posts
☐ Can edit profile
☐ Directory loads
☐ Search works
```

---

## 🆘 Common Issues & Solutions

### Issue: "Flutter not found"
```
Solution:
1. Download Flutter SDK
2. Extract to folder (e.g., ~/flutter)
3. Add to PATH:
   - Linux/Mac: Add to ~/.bashrc or ~/.zshrc
   - Windows: Add to Environment Variables
4. Run: flutter doctor
```

### Issue: "Credentials error" when running app
```
Solution:
1. Check if URL and Key are exactly copied
2. No quotes needed in main.dart:
   ✅ url: 'https://abc.supabase.co'  (correct)
   ❌ url: 'https://abc.supabase.co'' (wrong - extra quote)
3. Reload app: Press 'r' in terminal
```

### Issue: "Database connection failed"
```
Solution:
1. Check internet connection
2. Verify Supabase project is running (green status)
3. Check if tables exist in Supabase Table Editor
4. Try again: Press 'r' to reload app
```

### Issue: "Sign up fails" or "User exists"
```
Solution:
1. Create new test email each time
2. Or delete auth user in Supabase:
   - Dashboard → Authentication → Users
   - Click user → Delete
3. Try signup again
```

### Issue: "Posts don't appear"
```
Solution:
1. Check if post was created in database:
   - Supabase → Table Editor → posts
   - Should see your post there
2. If no posts in table:
   - Check RLS policies: Database → Policies
   - Should have "Posts are viewable by everyone"
3. Reload app: Press 'r'
```

### Issue: "Hot reload not working"
```
Solution:
- Instead of just 'r', try:
  - Press 'R' (capital) for full rebuild
  - Or stop and run: flutter run --no-fast-start
```

---

## 📞 Getting Help

1. **Check logs in terminal** - often shows exact error
2. **Read error message carefully** - gives hints
3. **Check Supabase logs**:
   - Dashboard → Logs (shows database errors)
4. **Check Flutter logs**:
   - Terminal should show detailed error messages
5. **Restart everything**:
   - Kill flutter run (Ctrl+C)
   - Restart emulator
   - Run `flutter pub get` again
   - Run `flutter run`

---

## 🎉 You're Ready!

Once all steps are complete:
1. ✅ You have working Flutter app
2. ✅ Connected to Supabase backend
3. ✅ Can test all features locally
4. ✅ Ready to add more features
5. ✅ Ready to deploy to stores

**Next:** See `App_Store_Deployment.md` for deployment steps!

---

**Created:** October 12, 2026
**Status:** Production Ready ✅
