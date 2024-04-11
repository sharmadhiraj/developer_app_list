import 'dart:convert';

/// A class representing an application.
class App {
  /// The unique identifier of the app.
  final String id;

  /// The name of the app.
  final String name;

  /// The category of the app.
  final String category;

  /// The name of the developer who created the app.
  final String developerName;

  /// The rating of the app.
  final double rating;

  /// The URL of the app's image.
  final String imageUrl;

  /// The URL of the app.
  final String url;

  /// Constructs a new [App] instance.
  const App({
    required this.id,
    required this.name,
    required this.category,
    required this.developerName,
    required this.rating,
    required this.imageUrl,
    required this.url,
  });

  @override
  String toString() {
    return jsonEncode({
      "ID": id,
      "Name": name,
      "Category": category,
      "Developer Name": developerName,
      "Rating": rating,
      "Image Url": imageUrl,
      "URL": url,
    });
  }
}
