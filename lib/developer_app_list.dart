/// A Dart/Flutter package to fetch a list of apps developed by a given developer from both the App Store and Play Store.

library;

import 'package:developer_app_list/models/app.dart';
import 'package:developer_app_list/util/util.dart';

/// Fetch apps developed by a specific developer.
class DeveloperAppList {
  /// Get Android apps by developer ID.
  /// Example developer URL: https://play.google.com/store/apps/dev?id=developerId
  static Future<List<App>> getAndroidApps({required String developerId}) async {
    return Util.getAndroidApps(developerId);
  }

  /// Get iOS apps by developer ID
  /// Example developer URL: https://apps.apple.com/us/developer/developer-name/developerId
  static Future<List<App>> getIosApps({required String developerId}) async {
    return Util.getIosApps(developerId);
  }
}
