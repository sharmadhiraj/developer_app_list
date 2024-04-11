/// A Flutter package to fetch a list of apps developed by a given developer
/// from the App Store and Play Store.
///
/// This package provides methods to retrieve lists of apps developed by a
/// specified developer for both Android and iOS platforms.
library developer_app_list;

import 'package:developer_app_list/models/app.dart';
import 'package:developer_app_list/util/util.dart';

/// A class containing methods to fetch lists of apps developed by a given
/// developer from the App Store and Play Store.
class DeveloperAppList {
  /// Retrieves a list of Android apps developed by the specified developer.
  ///
  /// The [developerId] parameter specifies the unique identifier of the
  /// developer whose apps are to be retrieved.
  ///
  /// Returns a Future that resolves to a list of [App] objects representing
  /// the Android apps developed by the specified developer.
  static Future<List<App>> getAndroidApps({required String developerId}) async {
    return Util.getAndroidApps(developerId);
  }

  /// Retrieves a list of iOS apps developed by the specified developer.
  ///
  /// The [developerId] parameter specifies the unique identifier of the
  /// developer whose apps are to be retrieved.
  ///
  /// Returns a Future that resolves to a list of [App] objects representing
  /// the iOS apps developed by the specified developer.
  static Future<List<App>> getIosApps({required String developerId}) async {
    return Util.getIosApps(developerId);
  }
}
