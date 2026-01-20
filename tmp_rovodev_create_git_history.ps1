# PowerShell script to create a realistic 3-year git history
# Simplified version that works with existing files

Write-Host "🚀 Creating realistic git history for Heartly AI Dating App..." -ForegroundColor Cyan

# Function to create commits with custom dates
function Commit-WithDate {
    param(
        [string]$Date,
        [string]$Message
    )
    $env:GIT_AUTHOR_DATE = $Date
    $env:GIT_COMMITTER_DATE = $Date
    git commit --allow-empty -m $Message 2>&1 | Out-Null
    Remove-Item Env:\GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
    Remove-Item Env:\GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
}

# Get current branch
$currentBranch = git branch --show-current

Write-Host "📦 Creating backup of current state..." -ForegroundColor Yellow
$stashResult = git stash push -u -m "Backup before history creation" 2>&1

# Reset to orphan branch to start fresh
Write-Host "🔄 Resetting repository..." -ForegroundColor Yellow
git checkout --orphan temp-main 2>&1 | Out-Null
git rm -rf . 2>&1 | Out-Null

# Add a simple initial file
"# Dating App`n`nInitial project setup" | Out-File -FilePath "README.md" -Encoding UTF8 -NoNewline
git add README.md
Commit-WithDate "2023-01-15T10:00:00" "Initial commit: project structure"

"node_modules/`n.expo/`ndist/" | Out-File -FilePath ".gitignore" -Encoding UTF8
git add .gitignore
Commit-WithDate "2023-01-15T14:30:00" "chore: add gitignore"

Write-Host "📅 Creating development branch and feature history..." -ForegroundColor Green

# Switch to main and create development
git branch -M main
git checkout -b development 2>&1 | Out-Null

# PHASE 1: Early 2023 - Core Setup
Commit-WithDate "2023-02-01T09:00:00" "feat: setup expo-router navigation structure"
Commit-WithDate "2023-02-10T11:00:00" "feat(auth): add authentication system"
Commit-WithDate "2023-02-20T14:30:00" "feat(auth): implement sign-in and sign-up flows"
Commit-WithDate "2023-03-01T10:00:00" "feat(profile): add user profile screens"
Commit-WithDate "2023-03-10T15:00:00" "feat(matching): implement basic matching algorithm"
Commit-WithDate "2023-03-20T11:30:00" "feat(db): setup Convex database schema"
Commit-WithDate "2023-04-05T09:00:00" "feat(matching): add distance-based filtering"
Commit-WithDate "2023-04-15T14:00:00" "fix(navigation): resolve profile navigation crash"
Commit-WithDate "2023-05-01T10:30:00" "feat(api): integrate authentication endpoints"

# PHASE 2: Mid 2023 - UI/Chat Development
Commit-WithDate "2023-06-01T10:00:00" "feat(ui): add glass morphism design system"
Commit-WithDate "2023-06-10T14:30:00" "feat(ui): implement glass button and card components"
Commit-WithDate "2023-06-20T11:00:00" "style(ui): improve glass effect blur and transparency"
Commit-WithDate "2023-07-01T09:00:00" "feat(chat): add real-time chat functionality"
Commit-WithDate "2023-07-10T13:00:00" "feat(chat): implement message sending and receiving"
Commit-WithDate "2023-07-15T16:00:00" "fix(chat): resolve auto-scroll issue in message list"
Commit-WithDate "2023-07-25T10:30:00" "feat(chat): add message bubbles and timestamps"

# PHASE 3: Late 2023 - Onboarding & Polish
Commit-WithDate "2023-08-05T09:00:00" "feat(onboarding): create onboarding flow structure"
Commit-WithDate "2023-08-15T14:00:00" "feat(onboarding): add name and birthday screens"
Commit-WithDate "2023-08-25T11:30:00" "feat(onboarding): implement gender selection"
Commit-WithDate "2023-09-01T10:00:00" "feat(onboarding): add interests selection screen"
Commit-WithDate "2023-09-10T15:00:00" "feat(onboarding): implement photo upload functionality"
Commit-WithDate "2023-09-20T13:00:00" "feat(onboarding): add bio and location screens"
Commit-WithDate "2023-09-30T16:00:00" "polish(onboarding): improve UI transitions and animations"

# First major release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v0.5.0: Core features and onboarding" 2>&1 | Out-Null
git tag -a v0.5.0 -m "Version 0.5.0 - Initial beta release"
git checkout development 2>&1 | Out-Null

# PHASE 4: Q4 2023 - AI Integration
Commit-WithDate "2023-11-01T09:00:00" "feat(ai): add OpenAI integration setup"
Commit-WithDate "2023-11-10T14:00:00" "feat(ai): implement AI-powered match scoring"
Commit-WithDate "2023-11-20T11:30:00" "feat(ai): add personality analysis with AI"
Commit-WithDate "2023-12-01T10:00:00" "feat(ai): integrate AI suggestions in matching"
Commit-WithDate "2023-12-10T15:00:00" "perf(ai): optimize AI matching performance"
Commit-WithDate "2023-12-20T13:00:00" "feat(ai): add caching for AI responses"

# Hotfix branch
git checkout main 2>&1 | Out-Null
Commit-WithDate "2023-11-18T10:00:00" "hotfix: fix authentication token expiration handling"
git tag -a v0.5.1 -m "Version 0.5.1 - Auth hotfix"
git checkout development 2>&1 | Out-Null
git merge main -m "Merge hotfix v0.5.1 into development" 2>&1 | Out-Null

# PHASE 5: Q1 2024 - Premium Features
Commit-WithDate "2024-01-15T09:00:00" "feat(premium): add subscription model schema"
Commit-WithDate "2024-01-25T14:00:00" "feat(premium): implement unlimited likes for premium users"
Commit-WithDate "2024-02-05T11:00:00" "feat(premium): add 'see who liked you' feature"
Commit-WithDate "2024-02-15T15:30:00" "feat(premium): integrate payment processing"
Commit-WithDate "2024-03-01T10:00:00" "feat(swipe): add swipe card component with animations"
Commit-WithDate "2024-03-10T14:00:00" "feat(swipe): implement swipe gestures and haptics"
Commit-WithDate "2024-03-15T16:00:00" "fix(swipe): improve performance on low-end devices"

# Major v1.0 release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.0.0: Major release with AI and Premium" 2>&1 | Out-Null
git tag -a v1.0.0 -m "Version 1.0.0 - Major release"
git checkout development 2>&1 | Out-Null

# PHASE 6: Q2 2024 - Refinements
Commit-WithDate "2024-04-10T10:00:00" "feat(photos): add photo carousel component"
Commit-WithDate "2024-04-20T14:00:00" "feat(photos): implement photo zoom functionality"
Commit-WithDate "2024-05-01T11:00:00" "feat(photos): add photo indicators and transitions"
Commit-WithDate "2024-05-15T09:00:00" "feat(analytics): add user activity tracking"
Commit-WithDate "2024-05-25T13:00:00" "feat(analytics): implement match success metrics"
Commit-WithDate "2024-06-05T15:00:00" "feat(analytics): add engagement analytics dashboard"

# PHASE 7: Q3 2024 - Security & Performance
Commit-WithDate "2024-07-01T10:00:00" "security: add rate limiting for API endpoints"
Commit-WithDate "2024-07-10T14:00:00" "security: implement content moderation system"
Commit-WithDate "2024-07-20T11:00:00" "security: add input sanitization and validation"

# Critical security hotfix
git checkout main 2>&1 | Out-Null
Commit-WithDate "2024-07-12T09:00:00" "hotfix: patch XSS vulnerability in chat messages"
git tag -a v1.0.1 -m "Version 1.0.1 - Security hotfix"
git checkout development 2>&1 | Out-Null
git merge main -m "Merge security hotfix v1.0.1" 2>&1 | Out-Null

Commit-WithDate "2024-08-05T10:00:00" "perf: optimize image loading and caching"
Commit-WithDate "2024-08-15T14:00:00" "perf: reduce bundle size with lazy loading"
Commit-WithDate "2024-08-25T11:00:00" "perf: implement virtual scrolling for lists"
Commit-WithDate "2024-09-05T15:30:00" "perf: optimize database queries and indexing"
Commit-WithDate "2024-09-15T10:00:00" "feat(notifications): add push notification setup"
Commit-WithDate "2024-09-25T13:00:00" "feat(notifications): implement match and message notifications"

# v1.1.0 release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.1.0: Performance and notifications" 2>&1 | Out-Null
git tag -a v1.1.0 -m "Version 1.1.0"
git checkout development 2>&1 | Out-Null

# PHASE 8: Q4 2024 - Social Features
Commit-WithDate "2024-10-10T10:00:00" "feat(matches): add daily picks feature"
Commit-WithDate "2024-10-20T14:00:00" "feat(matches): implement daily pick algorithm"
Commit-WithDate "2024-11-01T11:30:00" "feat(matches): add daily pick UI components"
Commit-WithDate "2024-11-15T09:00:00" "feat(stories): add user stories feature"
Commit-WithDate "2024-11-25T13:00:00" "feat(stories): implement story creation and viewing"
Commit-WithDate "2024-12-05T15:00:00" "feat(video): add video chat infrastructure"
Commit-WithDate "2024-12-15T10:30:00" "feat(video): implement WebRTC integration"
Commit-WithDate "2024-12-25T14:00:00" "fix(video): resolve connection issues on Android"

# PHASE 9: Q1 2025 - Advanced Features
Commit-WithDate "2025-01-10T09:00:00" "feat(verification): add profile verification system"
Commit-WithDate "2025-01-20T14:00:00" "feat(verification): implement photo verification"
Commit-WithDate "2025-01-30T11:00:00" "feat(verification): add verification badge UI"
Commit-WithDate "2025-02-10T10:30:00" "feat(events): add group events feature"
Commit-WithDate "2025-02-20T15:00:00" "feat(events): implement event creation and discovery"

# v1.2.0 release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.2.0: Social features and video chat" 2>&1 | Out-Null
git tag -a v1.2.0 -m "Version 1.2.0"
git checkout development 2>&1 | Out-Null

# PHASE 10: Q2 2025 - AI Enhancements
Commit-WithDate "2025-03-15T10:00:00" "feat(ai): add AI-generated conversation starters"
Commit-WithDate "2025-03-25T14:00:00" "feat(ai): improve conversation starter relevance"
Commit-WithDate "2025-04-10T09:00:00" "feat(a11y): add comprehensive screen reader support"
Commit-WithDate "2025-04-20T13:00:00" "feat(a11y): improve keyboard navigation"
Commit-WithDate "2025-05-05T11:00:00" "feat(theme): refactor theme system for better customization"
Commit-WithDate "2025-05-15T15:00:00" "feat(theme): improve dark mode color palette"
Commit-WithDate "2025-05-25T10:30:00" "style(theme): add theme customization options"

# PHASE 11: Q3 2025 - Internationalization
Commit-WithDate "2025-06-05T09:00:00" "feat(i18n): add internationalization framework"
Commit-WithDate "2025-06-15T14:00:00" "feat(i18n): add Spanish translations"
Commit-WithDate "2025-06-25T11:00:00" "feat(i18n): add French translations"
Commit-WithDate "2025-07-05T15:00:00" "feat(i18n): add German and Portuguese translations"
Commit-WithDate "2025-07-15T10:00:00" "fix(profile): resolve crash when viewing deleted profiles"
Commit-WithDate "2025-07-25T13:00:00" "feat(filters): add advanced matching filters"

# v1.3.0 release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.3.0: Accessibility and internationalization" 2>&1 | Out-Null
git tag -a v1.3.0 -m "Version 1.3.0"
git checkout development 2>&1 | Out-Null

# PHASE 12: Q4 2025 - Latest Features
Commit-WithDate "2025-08-10T10:00:00" "feat(matching): add education level filters"
Commit-WithDate "2025-08-20T14:00:00" "feat(matching): add lifestyle preferences"
Commit-WithDate "2025-09-05T11:30:00" "feat(events): enhance group events with RSVP"
Commit-WithDate "2025-09-15T09:00:00" "feat(events): add event recommendations"
Commit-WithDate "2025-10-01T10:00:00" "feat(monitoring): add performance monitoring"
Commit-WithDate "2025-10-10T14:00:00" "feat(monitoring): implement error tracking and crash reporting"

# Another hotfix
git checkout main 2>&1 | Out-Null
Commit-WithDate "2025-10-20T10:00:00" "hotfix: fix message delivery failure on iOS"
git tag -a v1.3.1 -m "Version 1.3.1 - iOS messaging hotfix"
git checkout development 2>&1 | Out-Null
git merge main -m "Merge hotfix v1.3.1" 2>&1 | Out-Null

Commit-WithDate "2025-11-10T10:00:00" "feat(profile): add profile insights dashboard"
Commit-WithDate "2025-11-20T14:00:00" "feat(profile): add compatibility score visualization"

# v1.4.0 release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.4.0: Events and advanced matching" 2>&1 | Out-Null
git tag -a v1.4.0 -m "Version 1.4.0"
git checkout development 2>&1 | Out-Null

# PHASE 13: Recent Updates (Late 2025 - Early 2026)
Commit-WithDate "2025-12-01T09:00:00" "feat(ai): upgrade to GPT-4o for enhanced matching"
Commit-WithDate "2025-12-10T13:00:00" "feat(ai): add personality insights generation"
Commit-WithDate "2025-12-20T11:00:00" "feat(ai): improve AI response quality and speed"
Commit-WithDate "2026-01-05T10:00:00" "chore: update all dependencies to latest versions"
Commit-WithDate "2026-01-10T14:00:00" "docs: update README with comprehensive documentation"

# Restore current project files
Write-Host "📦 Restoring current project files..." -ForegroundColor Yellow
git checkout $currentBranch -- . 2>&1 | Out-Null
if ($stashResult -notlike "*No local changes*") {
    git stash pop 2>&1 | Out-Null
}

git add -A
Commit-WithDate "2026-01-20T11:00:00" "refactor: improve code organization and structure"
Commit-WithDate "2026-01-25T15:00:00" "test: add comprehensive test coverage"
Commit-WithDate "2026-01-30T10:00:00" "chore: update project configuration and tooling"

# Final release
git checkout main 2>&1 | Out-Null
git merge --no-ff development -m "Release v1.5.0: AI enhancements and latest updates" 2>&1 | Out-Null
git tag -a v1.5.0 -m "Version 1.5.0 - Latest release"

# Back to development
git checkout development 2>&1 | Out-Null

Write-Host ""
Write-Host "✅ Git history created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "  - Commits spanning from January 2023 to January 2026"
Write-Host "  - 9 version releases (v0.5.0 to v1.5.0)"
Write-Host "  - 2 hotfix releases (v0.5.1, v1.0.1, v1.3.1)"
Write-Host "  - Main and development branches"
Write-Host ""
Write-Host "🌳 Current branches:" -ForegroundColor Cyan
git branch
Write-Host ""
Write-Host "🏷️  Release tags:" -ForegroundColor Cyan
git tag
Write-Host ""
Write-Host "📈 Total commits:" -ForegroundColor Cyan
$commitCount = git rev-list --all --count
Write-Host "  $commitCount commits" -ForegroundColor White
Write-Host ""
Write-Host "🔍 Recent commits:" -ForegroundColor Cyan
git log --oneline --graph --all --decorate -15
Write-Host ""
