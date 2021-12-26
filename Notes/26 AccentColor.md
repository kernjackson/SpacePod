# SpacePod 26 AccentColor

Let's make our app stand out with custom accent colors, and verify that it works nicely in light, dark, and high contrast mode.

## Deprecated Way

This method still works, but has been deprecated. Let's define the AccentColor in Assets instead.

```swift
ContentView()
    .accentColor(Color.purple)
```

## New Way

### Steps

1. In the Xcode Navigator...
2. Select **Assets**
3. Select **AccentColor**

We can set custom colors for different devices and display modes, but let's use a system color for now. Using a provided system color means the OS handles all the different display modes for us.

4. Select **Universal**
5. Set the universal color to `systemPurpleColor`

## Resources

[HIG: Visual Design Color](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/)
[.systemPurple](https://developer.apple.com/documentation/swiftui/color/purple-8yxzw)

## Diff

```diff
 {
   "colors" : [
     {
+      "color" : {
+        "platform" : "universal",
+        "reference" : "systemPurpleColor"
+      },
       "idiom" : "universal"
     }
   ],
```
