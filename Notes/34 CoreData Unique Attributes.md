# SpacePod 34 CoreData Unique Attributes

Let's ensure that all database entries are unique.

1. Add a constraint and change it to `date`
2. Add `container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy` to Persistence init

## Persistence.swift

```swift
...
container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
...
```
