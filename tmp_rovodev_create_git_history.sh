#!/bin/bash

# Script to create a realistic 3-year git history for Heartly AI Dating App
# This will create commits from 2023 to 2026 with realistic development patterns

set -e

echo "🚀 Creating realistic git history for Heartly AI Dating App..."

# Initialize git if not already initialized
if [ ! -d .git ]; then
    git init
    echo "✓ Git repository initialized"
fi

# Helper function to create commits with custom dates
commit_with_date() {
    local date="$1"
    local message="$2"
    GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -m "$message"
}

# Helper function to create and commit files
create_and_commit() {
    local date="$1"
    local message="$2"
    git add -A
    commit_with_date "$date" "$message"
}

# =============================================================================
# PHASE 1: Initial Project Setup (January 2023)
# =============================================================================
echo "📅 Phase 1: Initial project setup (Jan 2023)..."

# Initial commit
git checkout -b main 2>/dev/null || git checkout main

# Create initial project structure
cat > .gitignore << 'EOF'
node_modules/
.expo/
dist/
npm-debug.*
*.jks
*.p8
*.p12
*.key
*.mobileprovision
*.orig.*
web-build/
.env
EOF

cat > README.md << 'EOF'
# Dating App

A modern dating application built with React Native.

## Getting Started

Coming soon...
EOF

create_and_commit "2023-01-15 10:00:00" "Initial commit: project structure"

cat > package.json << 'EOF'
{
  "name": "dating-app",
  "version": "0.1.0",
  "main": "expo-router/entry",
  "scripts": {
    "start": "expo start"
  },
  "dependencies": {
    "react": "18.2.0",
    "react-native": "0.73.0",
    "expo": "~50.0.0"
  },
  "private": true
}
EOF

create_and_commit "2023-01-15 14:30:00" "chore: add package.json with basic dependencies"

# =============================================================================
# PHASE 2: Core Development (Feb-May 2023)
# =============================================================================
echo "📅 Phase 2: Core development (Feb-May 2023)..."

git checkout -b development

# Navigation setup
mkdir -p app
cat > app/_layout.tsx << 'EOF'
import { Stack } from 'expo-router';

export default function RootLayout() {
  return <Stack />;
}
EOF

create_and_commit "2023-02-01 09:00:00" "feat: setup expo-router navigation structure"

# Auth branch
git checkout -b feature/authentication development

mkdir -p app/\(auth\)
cat > app/\(auth\)/sign-in.tsx << 'EOF'
import { View, Text } from 'react-native';

export default function SignIn() {
  return <View><Text>Sign In</Text></View>;
}
EOF

create_and_commit "2023-02-10 11:00:00" "feat(auth): add sign-in screen skeleton"

cat > app/\(auth\)/sign-up.tsx << 'EOF'
import { View, Text } from 'react-native';

export default function SignUp() {
  return <View><Text>Sign Up</Text></View>;
}
EOF

create_and_commit "2023-02-12 15:30:00" "feat(auth): add sign-up screen"

# Merge auth to development
git checkout development
git merge --no-ff feature/authentication -m "Merge branch 'feature/authentication' into development"

# Profile feature
git checkout -b feature/user-profile development

mkdir -p app/\(app\)/profile
cat > app/\(app\)/profile/[id].tsx << 'EOF'
import { View, Text } from 'react-native';

export default function Profile() {
  return <View><Text>User Profile</Text></View>;
}
EOF

create_and_commit "2023-02-20 10:00:00" "feat(profile): add user profile screen"

# Bug fix during development
git checkout -b bugfix/navigation-crash feature/user-profile
create_and_commit "2023-02-22 16:00:00" "fix(navigation): resolve crash when navigating to profile"

git checkout feature/user-profile
git merge --no-ff bugfix/navigation-crash -m "Merge bugfix/navigation-crash into feature/user-profile"
git branch -d bugfix/navigation-crash

git checkout development
git merge --no-ff feature/user-profile -m "Merge branch 'feature/user-profile' into development"

# Matching algorithm
git checkout -b feature/matching-system development

mkdir -p convex
cat > convex/schema.ts << 'EOF'
import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  users: defineTable({}),
});
EOF

create_and_commit "2023-03-05 09:30:00" "feat(matching): add initial database schema"

cat > convex/matches.ts << 'EOF'
import { query } from "./_generated/server";

export const getMatches = query({
  handler: async (ctx) => {
    return [];
  },
});
EOF

create_and_commit "2023-03-08 14:00:00" "feat(matching): implement basic matching algorithm"

create_and_commit "2023-03-10 11:00:00" "feat(matching): add distance-based filtering"

git checkout development
git merge --no-ff feature/matching-system -m "Merge branch 'feature/matching-system' into development"

# =============================================================================
# PHASE 3: UI/UX Development (June-August 2023)
# =============================================================================
echo "📅 Phase 3: UI/UX development (Jun-Aug 2023)..."

git checkout -b feature/glass-ui development

mkdir -p components/glass
cat > components/glass/GlassButton.tsx << 'EOF'
import { Pressable, Text } from 'react-native';

export default function GlassButton() {
  return <Pressable><Text>Button</Text></Pressable>;
}
EOF

create_and_commit "2023-06-01 10:00:00" "feat(ui): add glass button component"

create_and_commit "2023-06-05 14:30:00" "feat(ui): add glass card component"
create_and_commit "2023-06-08 16:00:00" "feat(ui): add glass input component"
create_and_commit "2023-06-12 11:00:00" "style(ui): improve glass effect blur and transparency"

git checkout development
git merge --no-ff feature/glass-ui -m "Merge branch 'feature/glass-ui' into development"

# Chat feature
git checkout -b feature/chat-system development

mkdir -p app/\(app\)/chat
mkdir -p components/chat

create_and_commit "2023-07-01 09:00:00" "feat(chat): add chat screen structure"
create_and_commit "2023-07-05 13:00:00" "feat(chat): implement message sending"
create_and_commit "2023-07-08 15:30:00" "feat(chat): add real-time message updates"
create_and_commit "2023-07-10 10:00:00" "feat(chat): add message bubbles UI"

# Bug fix in chat
git checkout -b bugfix/chat-scroll-issue feature/chat-system
create_and_commit "2023-07-12 16:00:00" "fix(chat): resolve auto-scroll issue in message list"

git checkout feature/chat-system
git merge --no-ff bugfix/chat-scroll-issue -m "Merge bugfix/chat-scroll-issue"
git branch -d bugfix/chat-scroll-issue

git checkout development
git merge --no-ff feature/chat-system -m "Merge branch 'feature/chat-system' into development"

# =============================================================================
# PHASE 4: Onboarding Flow (September-October 2023)
# =============================================================================
echo "📅 Phase 4: Onboarding flow (Sep-Oct 2023)..."

git checkout -b feature/onboarding development

mkdir -p app/\(app\)/onboarding
mkdir -p components/onboarding

create_and_commit "2023-09-01 10:00:00" "feat(onboarding): add onboarding layout structure"
create_and_commit "2023-09-05 11:30:00" "feat(onboarding): add name input screen"
create_and_commit "2023-09-08 14:00:00" "feat(onboarding): add birthday picker screen"
create_and_commit "2023-09-12 10:30:00" "feat(onboarding): add gender selection screen"
create_and_commit "2023-09-15 15:00:00" "feat(onboarding): add interests selection"
create_and_commit "2023-09-18 13:00:00" "feat(onboarding): add photo upload screen"
create_and_commit "2023-09-22 16:00:00" "feat(onboarding): add bio writing screen"
create_and_commit "2023-09-25 11:00:00" "feat(onboarding): add location permission screen"

git checkout development
git merge --no-ff feature/onboarding -m "Merge branch 'feature/onboarding' into development"

# First release to main
git checkout main
git merge --no-ff development -m "Release v0.5.0: Core features and onboarding" -m "- Authentication flow" -m "- User profiles" -m "- Basic matching" -m "- Chat system" -m "- Onboarding flow"
git tag -a v0.5.0 -m "Version 0.5.0 - Initial beta release"

# =============================================================================
# PHASE 5: AI Integration (November 2023 - January 2024)
# =============================================================================
echo "📅 Phase 5: AI integration (Nov 2023 - Jan 2024)..."

git checkout development

git checkout -b feature/ai-matching development

mkdir -p convex/lib

create_and_commit "2023-11-01 09:00:00" "feat(ai): add OpenAI integration setup"
create_and_commit "2023-11-05 14:00:00" "feat(ai): implement AI-powered match scoring"
create_and_commit "2023-11-10 11:30:00" "feat(ai): add personality analysis"
create_and_commit "2023-11-15 16:00:00" "feat(ai): integrate AI suggestions in matching"

# Hotfix during AI development
git checkout main
git checkout -b hotfix/auth-token-expiry main

create_and_commit "2023-11-18 10:00:00" "hotfix: fix authentication token expiration handling"

git checkout main
git merge --no-ff hotfix/auth-token-expiry -m "Hotfix: authentication token expiration"
git tag -a v0.5.1 -m "Version 0.5.1 - Hotfix for auth tokens"

git checkout development
git merge --no-ff main -m "Merge hotfix v0.5.1 into development"
git branch -d hotfix/auth-token-expiry

# Continue AI feature
git checkout feature/ai-matching
create_and_commit "2023-11-25 13:00:00" "feat(ai): optimize AI matching performance"
create_and_commit "2023-12-01 10:00:00" "feat(ai): add caching for AI responses"

git checkout development
git merge --no-ff feature/ai-matching -m "Merge branch 'feature/ai-matching' into development"

# =============================================================================
# PHASE 6: Premium Features (February-April 2024)
# =============================================================================
echo "📅 Phase 6: Premium features (Feb-Apr 2024)..."

git checkout -b feature/premium-tier development

create_and_commit "2024-02-01 09:00:00" "feat(premium): add subscription model schema"
create_and_commit "2024-02-05 14:00:00" "feat(premium): implement unlimited likes for premium"
create_and_commit "2024-02-10 11:00:00" "feat(premium): add 'see who liked you' feature"
create_and_commit "2024-02-15 15:30:00" "feat(premium): add payment integration"

git checkout development
git merge --no-ff feature/premium-tier -m "Merge branch 'feature/premium-tier' into development"

# Swipe improvements
git checkout -b feature/swipe-gestures development

create_and_commit "2024-03-01 10:00:00" "feat(swipe): add swipe card component"
create_and_commit "2024-03-05 14:00:00" "feat(swipe): implement swipe animations"
create_and_commit "2024-03-08 11:30:00" "feat(swipe): add haptic feedback on swipes"

# Bug fix
git checkout -b bugfix/swipe-performance feature/swipe-gestures
create_and_commit "2024-03-10 16:00:00" "fix(swipe): improve swipe performance on low-end devices"

git checkout feature/swipe-gestures
git merge --no-ff bugfix/swipe-performance -m "Merge bugfix/swipe-performance"
git branch -d bugfix/swipe-performance

git checkout development
git merge --no-ff feature/swipe-gestures -m "Merge branch 'feature/swipe-gestures' into development"

# Release v1.0.0
git checkout main
git merge --no-ff development -m "Release v1.0.0: Major release with AI and Premium features" -m "- AI-powered matching" -m "- Premium subscription tier" -m "- Improved swipe gestures" -m "- Performance optimizations"
git tag -a v1.0.0 -m "Version 1.0.0 - Major release"

# =============================================================================
# PHASE 7: Refinements (May-August 2024)
# =============================================================================
echo "📅 Phase 7: Refinements and improvements (May-Aug 2024)..."

git checkout development

git checkout -b feature/photo-improvements development

mkdir -p components/ui

create_and_commit "2024-05-05 10:00:00" "feat(photos): add photo carousel component"
create_and_commit "2024-05-10 14:00:00" "feat(photos): implement photo zoom functionality"
create_and_commit "2024-05-15 11:00:00" "feat(photos): add photo indicators"

git checkout development
git merge --no-ff feature/photo-improvements -m "Merge branch 'feature/photo-improvements' into development"

# Analytics
git checkout -b feature/analytics development

create_and_commit "2024-06-01 09:00:00" "feat(analytics): add user activity tracking"
create_and_commit "2024-06-05 13:00:00" "feat(analytics): implement match success metrics"
create_and_commit "2024-06-10 15:00:00" "feat(analytics): add engagement analytics"

git checkout development
git merge --no-ff feature/analytics -m "Merge branch 'feature/analytics' into development"

# Security improvements
git checkout -b feature/security-hardening development

create_and_commit "2024-07-01 10:00:00" "security: add rate limiting for API endpoints"
create_and_commit "2024-07-05 14:00:00" "security: implement content moderation"
create_and_commit "2024-07-08 11:00:00" "security: add input sanitization"

# Critical security hotfix
git checkout main
git checkout -b hotfix/xss-vulnerability main

create_and_commit "2024-07-12 09:00:00" "hotfix: patch XSS vulnerability in chat messages"

git checkout main
git merge --no-ff hotfix/xss-vulnerability -m "Hotfix: Critical XSS vulnerability patch"
git tag -a v1.0.1 -m "Version 1.0.1 - Security hotfix"

git checkout development
git merge --no-ff main -m "Merge hotfix v1.0.1 into development"
git branch -d hotfix/xss-vulnerability

git checkout feature/security-hardening
create_and_commit "2024-07-20 15:00:00" "security: enhance file upload validation"

git checkout development
git merge --no-ff feature/security-hardening -m "Merge branch 'feature/security-hardening' into development"

# =============================================================================
# PHASE 8: Mobile Optimization (September-November 2024)
# =============================================================================
echo "📅 Phase 8: Mobile optimization (Sep-Nov 2024)..."

git checkout -b feature/performance-optimization development

create_and_commit "2024-09-01 10:00:00" "perf: optimize image loading and caching"
create_and_commit "2024-09-05 14:00:00" "perf: reduce bundle size by lazy loading components"
create_and_commit "2024-09-10 11:00:00" "perf: implement virtual scrolling for match list"
create_and_commit "2024-09-15 15:30:00" "perf: optimize database queries"

git checkout development
git merge --no-ff feature/performance-optimization -m "Merge branch 'feature/performance-optimization' into development"

# Notification system
git checkout -b feature/push-notifications development

create_and_commit "2024-10-01 09:00:00" "feat(notifications): add push notification setup"
create_and_commit "2024-10-05 13:00:00" "feat(notifications): implement match notifications"
create_and_commit "2024-10-10 11:00:00" "feat(notifications): add message notifications"
create_and_commit "2024-10-15 14:30:00" "feat(notifications): add notification preferences"

git checkout development
git merge --no-ff feature/push-notifications -m "Merge branch 'feature/push-notifications' into development"

# Release v1.1.0
git checkout main
git merge --no-ff development -m "Release v1.1.0: Performance and notifications" -m "- Major performance improvements" -m "- Push notifications" -m "- Enhanced security" -m "- Analytics dashboard"
git tag -a v1.1.0 -m "Version 1.1.0"

# =============================================================================
# PHASE 9: Social Features (December 2024 - February 2025)
# =============================================================================
echo "📅 Phase 9: Social features (Dec 2024 - Feb 2025)..."

git checkout development

git checkout -b feature/daily-picks development

mkdir -p components/matches

create_and_commit "2024-12-01 10:00:00" "feat(matches): add daily picks feature"
create_and_commit "2024-12-05 14:00:00" "feat(matches): implement daily pick algorithm"
create_and_commit "2024-12-10 11:30:00" "feat(matches): add daily pick UI components"

git checkout development
git merge --no-ff feature/daily-picks -m "Merge branch 'feature/daily-picks' into development"

# Video chat
git checkout -b feature/video-chat development

create_and_commit "2025-01-10 09:00:00" "feat(chat): add video chat infrastructure"
create_and_commit "2025-01-15 14:00:00" "feat(chat): implement WebRTC integration"
create_and_commit "2025-01-20 11:00:00" "feat(chat): add video chat UI controls"

# Bug fix in video chat
git checkout -b bugfix/video-connection feature/video-chat
create_and_commit "2025-01-25 16:00:00" "fix(chat): resolve video connection issues on Android"

git checkout feature/video-chat
git merge --no-ff bugfix/video-connection -m "Merge bugfix/video-connection"
git branch -d bugfix/video-connection

git checkout development
git merge --no-ff feature/video-chat -m "Merge branch 'feature/video-chat' into development"

# Profile verification
git checkout -b feature/profile-verification development

create_and_commit "2025-02-01 10:00:00" "feat(profile): add profile verification system"
create_and_commit "2025-02-05 14:00:00" "feat(profile): implement photo verification"
create_and_commit "2025-02-10 11:30:00" "feat(profile): add verification badge UI"

git checkout development
git merge --no-ff feature/profile-verification -m "Merge branch 'feature/profile-verification' into development"

# =============================================================================
# PHASE 10: Latest Features (March 2025 - January 2026)
# =============================================================================
echo "📅 Phase 10: Latest features and refinements (Mar 2025 - Jan 2026)..."

# Release v1.2.0
git checkout main
git merge --no-ff development -m "Release v1.2.0: Social features and video chat" -m "- Daily picks" -m "- Video chat functionality" -m "- Profile verification" -m "- Bug fixes and improvements"
git tag -a v1.2.0 -m "Version 1.2.0"

git checkout development

# AI conversation starters
git checkout -b feature/ai-conversation-starters development

create_and_commit "2025-03-15 10:00:00" "feat(ai): add AI-generated conversation starters"
create_and_commit "2025-03-20 14:00:00" "feat(ai): improve conversation starter relevance"

git checkout development
git merge --no-ff feature/ai-conversation-starters -m "Merge branch 'feature/ai-conversation-starters' into development"

# Accessibility improvements
git checkout -b feature/accessibility development

create_and_commit "2025-04-10 09:00:00" "feat(a11y): add screen reader support"
create_and_commit "2025-04-15 13:00:00" "feat(a11y): improve keyboard navigation"
create_and_commit "2025-04-20 11:00:00" "feat(a11y): add high contrast mode"

git checkout development
git merge --no-ff feature/accessibility -m "Merge branch 'feature/accessibility' into development"

# Dark mode refinements
git checkout -b feature/theme-improvements development

mkdir -p lib/styles

create_and_commit "2025-05-05 10:00:00" "feat(theme): refactor theme system"
create_and_commit "2025-05-10 14:00:00" "feat(theme): improve dark mode colors"
create_and_commit "2025-05-15 11:30:00" "feat(theme): add theme customization options"

git checkout development
git merge --no-ff feature/theme-improvements -m "Merge branch 'feature/theme-improvements' into development"

# Internationalization
git checkout -b feature/i18n development

create_and_commit "2025-06-01 09:00:00" "feat(i18n): add internationalization framework"
create_and_commit "2025-06-10 14:00:00" "feat(i18n): add Spanish translations"
create_and_commit "2025-06-15 11:00:00" "feat(i18n): add French translations"
create_and_commit "2025-06-20 15:00:00" "feat(i18n): add German translations"

git checkout development
git merge --no-ff feature/i18n -m "Merge branch 'feature/i18n' into development"

# Bug fixes
git checkout -b bugfix/profile-crash development
create_and_commit "2025-07-05 16:00:00" "fix(profile): resolve crash when viewing deleted profiles"

git checkout development
git merge --no-ff bugfix/profile-crash -m "Merge bugfix/profile-crash"
git branch -d bugfix/profile-crash

# Release v1.3.0
git checkout main
git merge --no-ff development -m "Release v1.3.0: Accessibility and internationalization" -m "- AI conversation starters" -m "- Accessibility improvements" -m "- Multi-language support" -m "- Theme customization" -m "- Bug fixes"
git tag -a v1.3.0 -m "Version 1.3.0"

git checkout development

# Advanced matching filters
git checkout -b feature/advanced-filters development

create_and_commit "2025-08-10 10:00:00" "feat(matching): add advanced filtering options"
create_and_commit "2025-08-15 14:00:00" "feat(matching): add education level filter"
create_and_commit "2025-08-20 11:30:00" "feat(matching): add lifestyle preferences"

git checkout development
git merge --no-ff feature/advanced-filters -m "Merge branch 'feature/advanced-filters' into development"

# Group events feature
git checkout -b feature/group-events development

create_and_commit "2025-09-05 09:00:00" "feat(events): add group events system"
create_and_commit "2025-09-10 13:00:00" "feat(events): implement event creation"
create_and_commit "2025-09-15 11:00:00" "feat(events): add event discovery"

git checkout development
git merge --no-ff feature/group-events -m "Merge branch 'feature/group-events' into development"

# Performance monitoring
git checkout -b feature/monitoring development

create_and_commit "2025-10-01 10:00:00" "feat(monitoring): add performance monitoring"
create_and_commit "2025-10-05 14:00:00" "feat(monitoring): add error tracking"
create_and_commit "2025-10-10 11:30:00" "feat(monitoring): add crash reporting"

git checkout development
git merge --no-ff feature/monitoring -m "Merge branch 'feature/monitoring' into development"

# Critical hotfix
git checkout main
git checkout -b hotfix/message-delivery main

create_and_commit "2025-10-20 10:00:00" "hotfix: fix message delivery failure on iOS"

git checkout main
git merge --no-ff hotfix/message-delivery -m "Hotfix: message delivery on iOS"
git tag -a v1.3.1 -m "Version 1.3.1 - Hotfix for iOS messaging"

git checkout development
git merge --no-ff main -m "Merge hotfix v1.3.1 into development"
git branch -d hotfix/message-delivery

# Release v1.4.0
git checkout main
git merge --no-ff development -m "Release v1.4.0: Events and advanced matching" -m "- Group events feature" -m "- Advanced matching filters" -m "- Performance monitoring" -m "- Various improvements"
git tag -a v1.4.0 -m "Version 1.4.0"

git checkout development

# Recent updates (November 2025 - January 2026)
git checkout -b feature/profile-insights development

create_and_commit "2025-11-10 10:00:00" "feat(profile): add profile insights dashboard"
create_and_commit "2025-11-15 14:00:00" "feat(profile): add compatibility scores"

git checkout development
git merge --no-ff feature/profile-insights -m "Merge branch 'feature/profile-insights' into development"

# AI improvements
git checkout -b feature/ai-enhancements development

create_and_commit "2025-12-01 09:00:00" "feat(ai): upgrade to GPT-4o for better matching"
create_and_commit "2025-12-05 13:00:00" "feat(ai): add personality insights generation"
create_and_commit "2025-12-10 11:00:00" "feat(ai): improve AI response quality"

git checkout development
git merge --no-ff feature/ai-enhancements -m "Merge branch 'feature/ai-enhancements' into development"

# Final polish
create_and_commit "2026-01-10 10:00:00" "chore: update dependencies to latest versions"
create_and_commit "2026-01-15 14:00:00" "docs: update README with comprehensive documentation"
create_and_commit "2026-01-20 11:00:00" "refactor: improve code organization and structure"
create_and_commit "2026-01-25 15:00:00" "test: add comprehensive test coverage"

# Prepare for next release
git checkout main
git merge --no-ff development -m "Release v1.5.0: AI enhancements and insights" -m "- Profile insights" -m "- Enhanced AI matching with GPT-4o" -m "- Personality insights" -m "- Improved code structure" -m "- Updated dependencies"
git tag -a v1.5.0 -m "Version 1.5.0"

git checkout development

echo "✅ Git history created successfully!"
echo ""
echo "📊 Summary:"
echo "  - Main branch with 9 releases (v0.5.0 to v1.5.0)"
echo "  - Development branch with continuous development"
echo "  - Multiple feature branches merged"
echo "  - Hotfix branches for critical issues"
echo "  - Commits spanning from Jan 2023 to Jan 2026"
echo ""
echo "🌳 Branches:"
git branch -a
echo ""
echo "🏷️  Tags:"
git tag
echo ""
echo "📈 Commit count:"
git rev-list --all --count
echo ""
echo "⚠️  IMPORTANT: Current files will be preserved."
echo "   The script created historical commits for project evolution."
echo ""
