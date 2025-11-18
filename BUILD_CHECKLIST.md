# Xcode Build Checklist

Before building in Xcode, follow these steps:

## ✅ Pre-Build Setup

### 1. Install Swift Packages
- [ ] Open Xcode
- [ ] File → Add Packages...
- [ ] Add: `https://github.com/supabase/supabase-swift`
- [ ] Add: `https://github.com/PostHog/posthog-ios`
- [ ] Wait for package resolution to complete

### 2. Configure API Keys
- [ ] Edit `Config/Supabase.plist`
  - Replace `your-project.supabase.co` with your actual URL
  - Replace `your-supabase-anon-key-here` with your anon key
- [ ] Edit `Config/PostHog.plist`
  - Replace `your-posthog-project-api-key-here` with your API key

### 3. Set Up Targets
- [ ] Select **Pulse** scheme
- [ ] Choose iOS 18.0+ Simulator or Device
- [ ] Verify bundle identifier: `com.yourcompany.pulse`

### 4. Configure App Groups
- [ ] Select Pulse target → Signing & Capabilities
- [ ] Verify App Groups capability exists
- [ ] Identifier should be: `group.com.yourcompany.pulse`
- [ ] Repeat for PulseWidget target
- [ ] Update identifier in `AppGroupStore.swift` if changed

## 🔨 Expected Build Issues (and Fixes)

### Issue: "No such module 'Supabase'"
**Fix:**
- File → Packages → Reset Package Caches
- Clean Build Folder (⌘⇧K)
- Build again (⌘B)

### Issue: "No such module 'PostHog'"
**Fix:** Same as above

### Issue: "Cannot find type 'Glass' in scope"
**Cause:** Liquid Glass APIs are iOS 26-only
**Fix:**
- Make sure deployment target is iOS 18.0+
- These are hypothetical APIs for the example
- You may need to replace with actual iOS 26 APIs when available

### Issue: "Failed to create ModelContainer"
**Fix:**
- Verify iOS 18.0+ deployment target
- Check SwiftData models are valid

### Issue: "App Group container not found"
**Fix:**
- Enable App Groups in both targets
- Use matching group identifier
- Update `AppGroupStore.swift` with your identifier

## ✅ First Build Steps

1. **Clean Build** (⌘⇧K)
2. **Build** (⌘B)
3. **Check for errors** in the Issue Navigator
4. **Fix import errors** (install packages)
5. **Fix configuration errors** (update plists)
6. **Build again** (⌘B)

## ⚠️ Known TODOs (Will Cause Runtime Warnings)

These are intentional stubs that need SDK integration:

### Supabase Methods
```swift
// SupabaseClient.swift - All methods need actual implementation
// Search for: // TODO: Implement
```

### PostHog Tracking
```swift
// PostHogManager.swift - SDK initialization
// Search for: // TODO: Initialize PostHog
```

### Widget Intents
```swift
// MarkSafeIntent.swift, TickTaskIntent.swift, RefreshPulseIntent.swift
// Need actual Supabase calls
```

## 🧪 Testing After Build

### 1. Test UI (Without API Keys)
- [ ] Launch app (⌘R)
- [ ] Should see WelcomeView (placeholder)
- [ ] Navigation should work
- [ ] Tabs should switch
- [ ] Settings toggles should work
- [ ] Console may show "Supabase configuration not found" (expected)

### 2. Test Permissions
- [ ] Settings → Enable location toggle
- [ ] System prompt should appear
- [ ] Grant permission
- [ ] Check console for "Location permission granted"

### 3. Test Widget
- [ ] Add widget to simulator home screen
  - Long press home screen
  - Tap + icon
  - Search "Pulse"
  - Add small/medium/large
- [ ] Widget should show placeholder data

### 4. Test Haptics
- [ ] Tap buttons in app
- [ ] Should feel vibration (on device)
- [ ] Console should show haptic events

## ✅ Build Success Checklist

- [ ] 0 errors in build
- [ ] App launches successfully
- [ ] No crashes on launch
- [ ] UI renders correctly
- [ ] Tabs navigate properly
- [ ] Widget can be added
- [ ] Console shows expected warnings (Supabase not configured, etc.)

## 🔧 After Successful Build

1. **Add your API keys** to plist files
2. **Run database migrations** in Supabase
3. **Test authentication flow**
4. **Implement TODO items** (search codebase for `// TODO:`)
5. **Test on real device** for location/Bluetooth

## 📊 Expected Build Output

```
Build succeeded
Product: Pulse.app
Duration: ~30-60 seconds (first build)

Warnings you might see:
⚠️ "Initialization of 'UNUserNotificationCenter' unavailable in application extensions"
   - This is expected for widget extension

⚠️ "Result of call to 'print' is unused"
   - Debug logging, can ignore

⚠️ "Immutable property will not be decoded..."
   - SwiftData warning, can ignore for now
```

## 🆘 Getting Help

If build fails:
1. Check the error message carefully
2. Most likely: Package not installed
3. Second most likely: Wrong iOS version
4. See SETUP.md for troubleshooting
5. Check console output for clues

## ✅ Success Criteria

**The build succeeds when:**
- Xcode shows "Build Succeeded"
- App launches in simulator
- No fatal errors
- UI is visible and interactive

**Runtime warnings are OK** - they're from unimplemented API calls.

---

**Ready to build?** Open the project in Xcode and follow this checklist! 🚀
