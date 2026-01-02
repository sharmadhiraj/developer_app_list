import 'dart:convert';

import 'package:developer_app_list/models/platform.dart';

/// Immutable model representing a store application.
class App {
  /// Unique application identifier (package name / App Store ID).
  final String id;

  /// Display name of the application.
  final String name;

  /// App category or genre.
  final String category;

  /// Developer or publisher name.
  final String developerName;

  /// Average user rating.
  final double rating;

  /// Primary app icon or artwork URL.
  final String imageUrl;

  /// Store page URL.
  final String url;

  /// Platform where the app is published.
  final AppPlatform platform;

  /// Whether the app is free to install.
  final bool isFree;

  /// Creates an immutable [App] instance.
  const App({
    required this.id,
    required this.name,
    required this.category,
    required this.developerName,
    required this.rating,
    required this.imageUrl,
    required this.url,
    required this.platform,
    required this.isFree,
  });

  @override
  String toString() {
    return jsonEncode({
      "id": id,
      "name": name,
      "category": category,
      "developer": developerName,
      "rating": rating,
      "imageUrl": imageUrl,
      "url": url,
      "platform": platform.name,
      "isFree": isFree,
    });
  }
}
