# Developer App List

A Dart/Flutter package to fetch apps developed by a specific developer from Google Play Store and
Apple
App Store.

Note: This package has no Flutter or UI dependencies and can be used in pure Dart projects as well.

### Features

- Fetch a list of Android apps by a developer.
- Fetch a list of iOS apps by a developer.

### Installation

Check installation instructions on [pub.dev](https://pub.dev/packages/developer_app_list/install).

### Usage

```
// Fetch Android apps
List<App> androidApps = await DeveloperAppList.getAndroidApps(
  developerId: 'developer_id',
);
// Example developer URL: https://play.google.com/store/apps/dev?id=developerId

// Fetch iOS apps
List<App> iosApps = await DeveloperAppList.getIosApps(
  developerId: 'developer_id',
);
// Example developer URL: https://apps.apple.com/us/developer/developer-name/developerId
}
```

Replace 'developer_id' with the actual developer ID.

### App Class

The `App` class represents a store application with the following properties:

`id`: Unique identifier (package name on Android / App Store ID on iOS)  
`name`: App display name  
`category`: App category or genre  
`developerName`: Name of the developer or publisher  
`rating`: Average user rating  
`imageUrl`: URL of the app icon or artwork.  
`url`:Store page URL
`platform`: Platform where the app is published (AppPlatform.android or AppPlatform.ios)  
`isFree`: Whether the app is free to install

<hr>

### Feedback and Contributions

Feedback, suggestions, or contributions are welcome. Feel free to open an issue or submit a pull
request. Happy coding!