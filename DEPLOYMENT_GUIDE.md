# 📱 Deployment Guide

## Deploy to Google Play Store (Android)

### Prerequisites
- Google Play Developer Account (₹2,500 one-time)
- Signing key
- App screenshots and store listing

### Step 1: Create Developer Account
```
1. Go to https://play.google.com/console
2. Click "Create account"
3. Fill in details (₹2,500 payment)
4. Accept agreements
5. Verify phone number
```

### Step 2: Generate Signing Key
```bash
cd android

# Generate keystore
keytool -genkey -v -keystore ~/maharashtra_key.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias maharashtra_key

# When prompted:
# Keystore password: (choose strong password)
# Key password: (same as above)
# First and last name: Your Name
# Organizational unit: Computer Teachers
# Organization: Maharashtra
# City: Your City
# State/Province: Maharashtra
# Country code: IN
```

### Step 3: Configure Signing
Create `android/key.properties`:
```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=maharashtra_key
storeFile=/home/username/maharashtra_key.jks
```

Update `android/app/build.gradle`:
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

### Step 4: Build Release APK
```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### Step 5: Upload to Play Store
```
1. Go to Google Play Console
2. Click "Create app"
3. Fill in:
   - App name: Maharashtra Computer Teacher
   - Default language: English
   - App or game: App
   - Category: Education
4. Click "Create app"
5. Go to "Release" → "Production"
6. Click "Create new release"
7. Upload app-release.aab
8. Fill in:
   - Release notes: "Initial release"
9. Click "Review and publish"
10. ✅ Wait 2-3 days for approval
```

### Store Listing Setup
```
1. "Store presence" section:
   - Short description: (max 80 chars)
   - Full description: (max 4000 chars)
   - Screenshots: 5 images (1080×1920px)
   - Feature graphic: 1024×500px
   - Icon: 512×512px PNG

2. Content rating:
   - Complete questionnaire
   - Auto-rated

3. Target audience:
   - Teachers/Educators

4. Pricing: Free
```

---

## Deploy to Apple App Store (iOS)

### Prerequisites
- macOS computer (required)
- Apple Developer Account (₹9,999/year)
- Signing certificates

### Step 1: Create Developer Account
```
1. Go to https://developer.apple.com/account
2. Sign in with Apple ID
3. Pay ₹9,999/year
4. Accept agreements
```

### Step 2: Setup Certificates
```
1. Open Xcode on macOS
2. Xcode → Settings → Accounts
3. Add your Apple ID
4. Click "Manage Certificates"
5. Create "iOS Development" certificate
6. Create "iOS Distribution" certificate
7. Download both certificates
```

### Step 3: Configure iOS Build
```bash
cd ios
pod install
cd ..

# Open in Xcode
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select "Runner" project
# 2. Select "Runner" target
# 3. Go to "Signing & Capabilities"
# 4. Select your Development team
# 5. Set signing certificate to iOS Distribution
```

### Step 4: Build IPA
```bash
flutter build ipa --release

# Output: build/ios/ipa/Runner.ipa
```

### Step 5: Upload to App Store
```
1. Go to https://appstoreconnect.apple.com
2. Click "My Apps"
3. Click "+"
4. Select "New App"
5. Fill in:
   - Platform: iOS
   - Name: Maharashtra Computer Teacher
   - Bundle ID: com.maharashtra.teacher
   - SKU: maharashtra-teacher-001
   - Category: Education

6. Fill "App Information":
   - Subtitle: Community for Teachers
   - Description: Full description...
   - Keywords: teacher,education,community

7. Add screenshots and preview video
8. Set "Age Rating"
9. Set price: Free
10. Submit for review

11. Upload IPA using Transporter app:
    - Download Transporter from App Store
    - Click "+"
    - Select Runner.ipa
    - Deliver
```

---

## Deploy to Web

### Option 1: Firebase Hosting (Free)
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize (first time only)
firebase init hosting

# Build web version
flutter build web --release

# Deploy
firebase deploy

# Your app is live at: yourproject.web.app
```

### Option 2: Your Own Server
```bash
# Build web
flutter build web --release

# Copy to server
scp -r build/web/* user@your-domain.com:/var/www/html/

# Make sure Nginx/Apache is configured
```

---

## Pre-Launch Checklist

### App Quality
- [ ] All features tested
- [ ] No crashes on test devices
- [ ] Load time < 2 seconds
- [ ] Works offline (if applicable)
- [ ] Dark mode works
- [ ] Responsive on all sizes

### Content
- [ ] App description clear
- [ ] Screenshots are professional
- [ ] Privacy policy updated
- [ ] Terms of service clear
- [ ] Contact email correct
- [ ] Support page works

### Testing
- [ ] Tested on Android 8+
- [ ] Tested on iOS 14+
- [ ] Tested on tablets
- [ ] Tested on slow networks
- [ ] All links work
- [ ] Forms validate

### Security
- [ ] No hardcoded secrets
- [ ] HTTPS enabled
- [ ] Database backed up
- [ ] API rate limiting works
- [ ] User data encrypted

### Store Optimization
- [ ] Listing complete
- [ ] Keywords optimized
- [ ] Category correct
- [ ] Age rating accurate
- [ ] Screenshots 1080×1920px (Android)
- [ ] Preview video (iOS)

---

## Launch Timeline

```
Week 1: Finalize & Test
- [ ] All features working
- [ ] No bugs found
- [ ] Screenshots ready
- [ ] Listing written

Week 2: Submit
- [ ] Google Play (2-3 days)
- [ ] Apple App Store (1-3 days)

Week 3: Launch!
- [ ] Both stores go live
- [ ] Send announcement
- [ ] Social media campaign
- [ ] Monitor crash reports

Week 4+: Monitor & Improve
- [ ] Fix bugs quickly
- [ ] Respond to reviews
- [ ] Plan next features
```

---

## Cost Summary

| Item | Cost | Notes |
|------|------|-------|
| Google Play | ₹2,500 | One-time |
| Apple Developer | ₹9,999 | Annual |
| Domain name | ₹500-1000 | Optional |
| Server/Hosting | ₹300-500/mo | For Supabase Pro |
| **TOTAL** | **₹12,999+** | One-time setup |

---

## After Launch

### Monitor Performance
```
1. Check crash reports daily
2. Monitor app ratings
3. Respond to negative reviews
4. Track user feedback
5. Plan bug fixes
```

### Plan Updates
```
1. Gather feature requests
2. Prioritize improvements
3. Test thoroughly
4. Submit updates every 2-4 weeks
5. Keep users engaged
```

### Scale Up
```
After 1000+ users:
1. Migrate to Node.js backend
2. Add payment processing
3. Implement admin dashboard
4. Add push notifications
5. Optimize performance
```

---

**Important:** Save your signing keys and certificates! You'll need them for future updates.

Last Updated: October 12, 2026
