# SpacePod 38 Debugging with Console

We've got two warnings that have been bothering me for a while now. Let's see what we can do to fix them.

[YouTube](https://youtu.be/oiX07mQsoE0)

## Goals

1. Eliminate Warnings
2. Use Console
3. Use Breakpoints

### Warnings to Fix

1. CoreData Warning
2. Broken AutoLayout

## 1 CoreData Warning

### Console

```
SpacePod[1241:3102508] [error] warning:  View context accessed for persistent container Model with no stores loaded
CoreData: warning:  View context accessed for persistent container Model with no stores loaded
```

### Troubleshooting

Reading the message I see our first clue. Xcode's Core Data template code has the same warning, but only once. Let's set a breakpoint to see when this warning is logged. We can see it's happening when we set our merge policies.

### The Fix

If we make our configuration changes **after** we load the persistent store the warning goes away.

```diff
-   container.viewContext.automaticallyMergesChangesFromParent = true
-   container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            ...
         })
+        container.viewContext.automaticallyMergesChangesFromParent = true
+        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
     }
```

## Broken AutoLayout

### Console

```swift
2022-01-06 18:36:07.689295-0600 SpacePod[1317:3105452] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want.
	Try this:
		(1) look at each constraint and try to figure out which you don't expect;
		(2) find the code that added the unwanted constraint or constraints and fix it.
(
    "<NSLayoutConstraint:0x60000326c1e0 'BIB_Trailing_CB_Leading' H:[_UIModernBarButton:0x140e239f0]-(6)-[_UIModernBarButton:0x140e1e280'SpacePod']   (active)>",
    "<NSLayoutConstraint:0x60000326c230 'CB_Trailing_Trailing' _UIModernBarButton:0x140e1e280'SpacePod'.trailing <= BackButton.trailing   (active, names: BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000326d040 'UINav_static_button_horiz_position' _UIModernBarButton:0x140e239f0.leading == UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'.leading   (active)>",
    "<NSLayoutConstraint:0x60000326d090 'UINavItemContentGuide-leading' H:[BackButton]-(6)-[UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide']   (active, names: BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000323ef80 'UINavItemContentGuide-trailing' UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide'.trailing == _UINavigationBarContentView:0x140e1acc0.trailing   (active)>",
    "<NSLayoutConstraint:0x60000326f980 'UIView-Encapsulated-Layout-Width' _UINavigationBarContentView:0x140e1acc0.width == 0   (active)>",
    "<NSLayoutConstraint:0x60000323f340 'UIView-leftMargin-guide-constraint' H:|-(8)-[UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'](LTR)   (active, names: '|':_UINavigationBarContentView:0x140e1acc0 )>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x60000326c1e0 'BIB_Trailing_CB_Leading' H:[_UIModernBarButton:0x140e239f0]-(6)-[_UIModernBarButton:0x140e1e280'SpacePod']   (active)>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
2022-01-06 18:36:07.689830-0600 SpacePod[1317:3105452] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want.
	Try this:
		(1) look at each constraint and try to figure out which you don't expect;
		(2) find the code that added the unwanted constraint or constraints and fix it.
(
    "<NSLayoutConstraint:0x60000326c190 'BIB_Leading_Leading' H:|-(0)-[_UIModernBarButton:0x140e239f0]   (active, names: BackButton:0x140e17960, '|':BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000326d040 'UINav_static_button_horiz_position' _UIModernBarButton:0x140e239f0.leading == UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'.leading   (active)>",
    "<NSLayoutConstraint:0x60000326d090 'UINavItemContentGuide-leading' H:[BackButton]-(6)-[UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide']   (active, names: BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000323ef80 'UINavItemContentGuide-trailing' UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide'.trailing == _UINavigationBarContentView:0x140e1acc0.trailing   (active)>",
    "<NSLayoutConstraint:0x60000326f980 'UIView-Encapsulated-Layout-Width' _UINavigationBarContentView:0x140e1acc0.width == 0   (active)>",
    "<NSLayoutConstraint:0x60000323f340 'UIView-leftMargin-guide-constraint' H:|-(8)-[UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'](LTR)   (active, names: '|':_UINavigationBarContentView:0x140e1acc0 )>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x60000326c190 'BIB_Leading_Leading' H:|-(0)-[_UIModernBarButton:0x140e239f0]   (active, names: BackButton:0x140e17960, '|':BackButton:0x140e17960 )>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
2022-01-06 18:36:07.704019-0600 SpacePod[1317:3105452] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want.
	Try this:
		(1) look at each constraint and try to figure out which you don't expect;
		(2) find the code that added the unwanted constraint or constraints and fix it.
(
    "<NSLayoutConstraint:0x600003268500 UIView:0x140e19890.trailing == _UIBackButtonMaskView:0x140e7cd30.trailing   (active)>",
    "<NSLayoutConstraint:0x60000326c7d0 'Mask_Trailing_Trailing' _UIBackButtonMaskView:0x140e7cd30.trailing == BackButton.trailing   (active, names: BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000326c910 'MaskEV_Leading_BIB_Trailing' H:[_UIModernBarButton:0x140e239f0]-(0)-[UIView:0x140e19890]   (active)>",
    "<NSLayoutConstraint:0x60000326d040 'UINav_static_button_horiz_position' _UIModernBarButton:0x140e239f0.leading == UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'.leading   (active)>",
    "<NSLayoutConstraint:0x60000326d090 'UINavItemContentGuide-leading' H:[BackButton]-(6)-[UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide']   (active, names: BackButton:0x140e17960 )>",
    "<NSLayoutConstraint:0x60000323ef80 'UINavItemContentGuide-trailing' UILayoutGuide:0x60000280c1c0'UINavigationBarItemContentLayoutGuide'.trailing == _UINavigationBarContentView:0x140e1acc0.trailing   (active)>",
    "<NSLayoutConstraint:0x60000326f980 'UIView-Encapsulated-Layout-Width' _UINavigationBarContentView:0x140e1acc0.width == 0   (active)>",
    "<NSLayoutConstraint:0x60000323f340 'UIView-leftMargin-guide-constraint' H:|-(8)-[UILayoutGuide:0x60000280cd20'UIViewLayoutMarginsGuide'](LTR)   (active, names: '|':_UINavigationBarContentView:0x140e1acc0 )>"
)

Will attempt to recover by breaking constraint
<NSLayoutConstraint:0x600003268500 UIView:0x140e19890.trailing == _UIBackButtonMaskView:0x140e7cd30.trailing   (active)>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
```

### Troubleshooting

After reading through the conosle output it looks like the issue is with the navigation title. We'll be adding a toolbar there fairly soon anyway, so let's just remove the offending line for now.

### The Workaround

```diff
-   .navigationTitle("SpacePod")
    .navigationBarTitleDisplayMode(.inline)
```
