import 'dart:convert';
import 'dart:io';

import 'package:developer_app_list/models/app.dart';

class Util {
  static Future<String?> _fetchUrl(String url) async {
    final HttpClient client = HttpClient();
    try {
      final HttpClientRequest request = await client.getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        return await utf8.decodeStream(response);
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      client.close();
    }
    return null;
  }

  static Future<List<App>> getAndroidApps(String id) async {
    String? content = await Util._fetchUrl(
      "https://play.google.com/store/apps/developer?id=${id.replaceAll(" ", "+")}",
    );
    final List<App> apps = [];
    if (content != null) {
      int start = content.indexOf("AF_initDataCallback({key: 'ds:3',");
      start = content.indexOf("data:", start) + 5;
      final int end = content.indexOf(", sideChannel:", start);
      content = content.substring(start, end);
      for (dynamic item in jsonDecode(content)[0][1][0][22][0]) {
        item = item[0];
        apps.add(
          App(
            id: item[0][0],
            name: item[3],
            category: item[5],
            developerName: item[14],
            rating: double.tryParse(item[4][0]) ?? 0,
            imageUrl: item[1][3][2],
            url:
                "https://play.google.com/store/apps/details?id=np.com.dhirajsharma.football_score${item[0][0]}",
          ),
        );
      }
    }
    return apps;
  }

  static Future<List<App>> getIosApps(String id) async {
    String? content = await Util._fetchUrl(
      "https://apps.apple.com/us/developer/x/$id?see-all=i-phonei-pad-apps",
    );
    final List<App> apps = [];
    if (content != null) {
      int start = content.indexOf('shoebox-media-api-cache-apps">') + 30;
      final int end = content.indexOf("</script", start);
      content = content.substring(start, end);

      for (dynamic item in jsonDecode(
              (jsonDecode(content) as Map<String, dynamic>).values.first)["d"]
          [0]["relationships"]["ios-apps"]["data"]) {
        final Map<String, dynamic> attributes = item["attributes"];
        apps.add(
          App(
            id: item["id"],
            name: attributes["name"],
            category: attributes["genreDisplayName"],
            developerName: attributes["artistName"],
            rating:
                double.tryParse(attributes["userRating"]["value"].toString()) ??
                    0,
            imageUrl: (attributes["platformAttributes"]["ios"]["artwork"]["url"]
                    as String)
                .replaceAll("{w}x{h}{c}.{f}", "512x0w.png"),
            url: attributes["url"],
          ),
        );
      }
    }
    return apps;
  }
}
