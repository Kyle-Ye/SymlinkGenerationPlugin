# SymlinkGenerationPlugin

Generate symlinks within a SPM package for Objective-c code

## Usage

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(path: "../SymlinkGenerationPlugin"), // Only support local dependency for now
    ],
    targets: [
        .target(
            name: "xx",
            plugins: [
                .plugin(name: "SymlinkGenerationPlugin", package: "SymlinkGenerationPlugin"),
            ]
        ),
    ]
)
```

## Explanation

As discussed here: https://forums.swift.org/t/plugin-generated-header-files-are-not-available-from-project/56875, SwiftPM's build tool plugins only support generating Swift code.

So if we want to generate Objective-c header file, we need to use `prebuildCommand` if we choose to use buildTool plugin.
> buildCommand will gives us a permission error due to sandbox limitation

A `buildCommand` can use an execuatableTarget as a dependency to use, and a `prebuildCommand` can't.
So I have to use a swift script to replace the execuatableTarget.

And due to the actual implementation is not a real executable, its path can't got from `context.tool(named:)` API. So I have to hardcode the path to be the same directory of downloadstream package.

And that's why this package could only be a local dependency for now.

If you have a better ideal, PR is welcomed.