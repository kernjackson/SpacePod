# SpacePod 44 Xcode Markdown Syntax Highlighting

If we place a hidden plist in the project directory Xcode will render it, but we won't be able to edit the file. Instead, we'll explicitly set the filetype on our markdown files so that Xcode knows how to highlight them.

## Steps

1. Select markdown files
2. Open the inspector
3. Change **Type** to **Markdown Text**

The active file won't re-render unless it is closed and reopened. If that doesn't work close and reopen the project.
