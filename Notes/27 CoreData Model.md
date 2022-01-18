# SpacePod 26 Creating a CoreData Model

So far we've just been hitting the API anytime we need to display some day. Let's create a Core Data model that will let us cache the JSON payload.

[YouTube](https://youtu.be/HjsSj4Niog8)

## Problem

We're hitting the API every time we need some data.

## Steps

1. Create a new file of type Data Model
2. Add an Entity named NASA
3. Add an attribute for each property from `Pod.swift`

- date: Date?
- url: URI?
- hdurl: URI?
- thumbnailUrl: URI?
- title: String?
- copyright: String?
- explanation: String?
- mediaType: String?
- serviceVersion: String?

## DIFF

```xml
<model type="com.apple.IDECoreDataModeler.DataModel" documentVersion="1.0" lastSavedToolsVersion="19574" systemVersion="21A559" minimumToolsVersion="Automatic" sourceLanguage="Swift" userDefinedModelVersionIdentifier="">
<entity name="NASA" representedClassName="NASA" syncable="YES" codeGenerationType="class">
    <attribute name="copyright" optional="YES" attributeType="String"/>
    <attribute name="date" optional="YES" attributeType="Date" usesScalarValueType="NO"/>
    <attribute name="explanation" optional="YES" attributeType="String"/>
    <attribute name="hdurl" optional="YES" attributeType="URI"/>
    <attribute name="mediaType" optional="YES" attributeType="String"/>
    <attribute name="serviceVersion" optional="YES" attributeType="String"/>
    <attribute name="thumbnailUrl" optional="YES" attributeType="URI"/>
    <attribute name="title" optional="YES" attributeType="String"/>
    <attribute name="url" optional="YES" attributeType="URI"/>
</entity>
</model>
```
