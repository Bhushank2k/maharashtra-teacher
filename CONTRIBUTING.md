# 🤝 Contributing Guide

Thank you for your interest in contributing to Maharashtra Computer Teacher! This document provides guidelines for contributing.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Report issues professionally
- Help others in the community
- Follow this project's values and mission

## Getting Started

### 1. Fork the Repository
```bash
# On GitHub, click "Fork" button
```

### 2. Clone Your Fork
```bash
git clone https://github.com/YOUR_USERNAME/maharashtra-teacher.git
cd maharashtra-teacher
```

### 3. Add Upstream Remote
```bash
git remote add upstream https://github.com/ORIGINAL_OWNER/maharashtra-teacher.git
```

### 4. Create Feature Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b bugfix/bug-description
```

## Types of Contributions

### 🐛 Bug Reports
1. Check if bug already reported
2. Create GitHub Issue with:
   - Clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Device/OS information

### ✨ Feature Requests
1. Check if feature already requested
2. Create GitHub Issue with:
   - Clear description
   - Use case/motivation
   - Proposed implementation
   - Examples or mockups
3. Discuss with maintainers
4. Get approval before implementing

### 📝 Documentation
1. Fork repository
2. Improve docs (README, guides, etc.)
3. Submit PR with clear description
4. Wait for review and merge

### 💻 Code Contributions
Follow this process:

1. **Create feature branch**
```bash
git checkout -b feature/my-feature
```

2. **Make changes**
- Write clean, readable code
- Add comments for complex logic
- Follow style guide (see below)

3. **Format code**
```bash
flutter format .
flutter analyze
```

4. **Test changes**
```bash
flutter test
# or
flutter run
```

5. **Commit changes**
```bash
git add .
git commit -m "feat: add new feature description"
```

6. **Push to your fork**
```bash
git push origin feature/my-feature
```

7. **Create Pull Request**
- Go to GitHub
- Compare & create PR
- Add description
- Reference related issues
- Wait for review

8. **Address feedback**
- Make requested changes
- Push updates
- Re-request review

9. **Merge**
- Maintainer merges PR
- Branch is deleted
- Your contribution is live!

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Code formatting
- `refactor:` Code refactoring
- `perf:` Performance improvement
- `test:` Adding tests
- `chore:` Build, deps, etc.

### Examples
```
feat(auth): add email verification

fix(posts): prevent duplicate post creation

docs(setup): improve installation guide

style: format code with flutter format

test(models): add user model tests
```

## Code Style Guide

### Naming
```dart
// ✅ Good
class UserProfile { }
void getUserById() { }
const MAX_USERS = 100;
final userName = 'John';

// ❌ Bad
class user_profile { }
void get_user_by_id() { }
const maxUsers = 100;
final UserName = 'John';
```

### Formatting
```dart
// Use flutter format
flutter format .

// Dart conventions
- Use const where possible
- Avoid null checks with !
- Use final for variables that don't change
- Comment public APIs
```

### Documentation
```dart
/// User profile model
/// 
/// Represents a user in the Maharashtra Teacher platform.
/// Each user has an email, name, and optional profile details.
class User {
  /// User's unique identifier
  final String id;
  
  /// User's email address (must be unique)
  final String email;
  
  /// Create a new User
  User({required this.id, required this.email});
}
```

## Pull Request Process

### Before Submitting
- [ ] Fork and branch created
- [ ] Code is formatted (`flutter format .`)
- [ ] Code analyzed (`flutter analyze`)
- [ ] Tests pass (`flutter test`)
- [ ] Tests added for new features
- [ ] Documentation updated
- [ ] No breaking changes (or discussed)

### PR Title Format
```
[type] Brief description

Examples:
[feature] Add email verification
[fix] Fix post deletion bug
[docs] Update installation guide
[refactor] Simplify user model
```

### PR Description
```markdown
## Description
Brief description of changes

## Motivation
Why is this change needed?

## Changes
- List of changes made
- Be specific and clear

## Testing
How to test these changes

## Related Issues
Fixes #123
Related to #456

## Screenshots (if applicable)
[Screenshot of feature]

## Checklist
- [ ] Code formatted
- [ ] Tests pass
- [ ] Documentation updated
- [ ] No console warnings
```

### Review Process
1. Maintainer reviews code
2. Feedback provided (if needed)
3. You make requested changes
4. Re-requested and approved
5. Merged to main branch

## Development Tips

### Useful Commands
```bash
# Setup
git clone https://github.com/YOUR_USERNAME/maharashtra-teacher.git
cd maharashtra-teacher
flutter pub get

# Development
flutter run                    # Run debug
flutter run -d chrome         # Run on web
flutter test                  # Run tests
flutter analyze               # Check code
flutter format .              # Format code

# Cleanup
flutter clean                 # Clean build
git clean -fd                 # Remove untracked files
```

### Testing Your Changes
```bash
# Test locally before submitting
flutter test

# Test on multiple devices
flutter run -d all

# Build release to test performance
flutter build apk --release
```

### Keeping Fork Updated
```bash
# Fetch upstream changes
git fetch upstream

# Rebase on main
git rebase upstream/main

# Force push to your fork
git push -f origin main
```

## Areas to Contribute

### Good for Beginners
- [ ] Documentation improvements
- [ ] Bug fixes (labeled as `good-first-issue`)
- [ ] UI improvements
- [ ] Test coverage
- [ ] Example code

### Intermediate
- [ ] New features (agreed upon)
- [ ] Performance improvements
- [ ] Refactoring code
- [ ] Architecture improvements

### Advanced
- [ ] Major features
- [ ] Backend migration
- [ ] Performance optimization
- [ ] Security improvements

## Resources

- [Flutter Documentation](https://flutter.dev)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Material Design](https://material.io)
- [Git Guide](https://git-scm.com)
- [GitHub Help](https://help.github.com)

## Getting Help

- **Questions**: Create a Discussion on GitHub
- **Issues**: Search existing issues first
- **Chat**: Join our Discord/community
- **Docs**: Check README and guides
- **Code Review**: Ask maintainers

## Recognition

Contributors are recognized in:
- README contributors section
- Release notes
- GitHub contributors page
- Community shout-outs

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

## Contact

- **Issues**: GitHub Issues
- **Email**: dev@maharashtra-teacher.com (if applicable)
- **Discord**: [Join our community](link)

---

## Thank You! 🙏

Your contributions help make Maharashtra Computer Teacher better for all teachers. We appreciate your time and effort!

---

**Last Updated**: October 18, 2026  
**Maintained By**: Project Team
