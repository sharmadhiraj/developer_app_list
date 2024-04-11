# Developer App List

A Flutter package to fetch a list of apps developed by a given developer from both the App Store and
Play Store.

### Features

- Retrieve a list of Android apps developed by a specific developer.
- Retrieve a list of iOS apps developed by a specific developer.

### Installation

To use this package, add `developer_app_list` as
a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

```yaml
dependencies:
  developer_app_list: ^0.0.1
```

### Usage

```dart
import 'package:developer_app_list/developer_app_list.dart';

void main() async {
  // Example usage to fetch Android apps
  List<App> androidApps = await DeveloperAppList.getAndroidApps(developerId: 'developer_id');

  // Example usage to fetch iOS apps
  List<App> iosApps = await DeveloperAppList.getIosApps(developerId: 'developer_id');
}
```

Replace 'developer_id' with the actual developer ID whose apps you want to fetch.

The **App** class represents an application and contains the following properties:

`id`: Unique identifier of the app.  
`name`: Name of the app.  
`category`: Category of the app.  
`developerName`: Name of the developer who created the app.  
`rating`: Rating of the app.  
`imageUrl`: URL of the app's image.  
`url`: URL of the app.

### Feedback and Contributions

This is the first version of the app, and I am actively working on adding new features and
improvements. If you have any feedback, suggestions, or queries, feel free to reach out. Happy
coding!