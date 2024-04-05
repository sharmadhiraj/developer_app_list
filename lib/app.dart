import 'dart:convert';

class App {
  final String id;
  final String name;
  final String category;
  final String developerName;
  final double rating;
  final String imageUrl;
  final String url;

  App({
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
