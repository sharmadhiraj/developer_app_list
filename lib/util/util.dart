import 'dart:convert';
import 'dart:io';

import 'package:developer_app_list/models/app.dart';
import 'package:developer_app_list/models/platform.dart';

class Util {
  static Future<String?> _fetchUrl(String url) async {
    // dPrint(url);
    final HttpClient client = HttpClient();
    try {
      final HttpClientRequest request = await client.getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        return await utf8.decodeStream(response);
      } else {
        dPrint("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      dPrint("Error: $error");
    } finally {
      client.close(force: true);
    }
    return null;
  }

  static Future<List<App>> getAndroidApps(String developerId) async {
    try {
      final String? pageContent = await Util._fetchUrl(
        "https://play.google.com/store/apps/dev?id=${developerId.replaceAll(' ', '+')}",
      );
      if (pageContent == null) {
        return [];
      }
      int dataStart = pageContent.indexOf("AF_initDataCallback({key: 'ds:3',");
      dataStart = pageContent.indexOf("data:", dataStart) + 5;
      final int dataEnd = pageContent.indexOf(", sideChannel:", dataStart);

      final String jsonDataString = pageContent.substring(dataStart, dataEnd);
      final List<dynamic> appItems = (jsonDecode(jsonDataString) as dynamic)[0]
          [1][0][21][0] as List<dynamic>;
      return appItems
          .map(
            (i) => App(
              id: i[0][0],
              name: i[3],
              category: i[5],
              developerName: i[14],
              rating:
                  (i[4] as List).isEmpty ? 0 : double.tryParse(i[4][0]) ?? 0,
              imageUrl: i[1][3][2],
              url: "https://play.google.com/store/apps/details?id=${i[0][0]}",
              platform: AppPlatform.android,
              isFree: i[7] == null || i[7].isEmpty,
            ),
          )
          .toList();
    } catch (e) {
      dPrint("Exception while parsing Android apps: $e");
    }
    return [];
  }

  static Future<List<App>> getIosApps(String id) async {
    id = id.split("/").last;
    if (!RegExp(r'^id\d+$').hasMatch(id)) {
      dPrint("Invalid Apple developer ID format: $id");
      return [];
    }
    try {
      final String? pageContent = await Util._fetchUrl(
        "https://apps.apple.com/us/developer/x/$id?see-all=i-phonei-pad-apps",
      );
      if (pageContent == null) {
        return [];
      }
      final Map<String, String> categoriesMap = Map<String, String>.fromEntries(
        (_parseScriptTagData(
          pageContent: pageContent,
          scriptId: "developer",
        )["hasOfferCatalog"]["itemListElement"] as List)
            .whereType<Map>()
            .map(
              (i) => MapEntry(
                i["name"],
                i["applicationCategory"],
              ),
            ),
      );
      final List<dynamic> shelves = (_parseScriptTagData(
        pageContent: pageContent,
        scriptId: "serialized-server-data",
      ) as List)
          .first["data"]["shelves"];
      final List<dynamic> appItems = shelves.firstWhere(
            (i) => i["impressionMetrics"]["fields"]["name"] == "iPad & iPhone",
            orElse: () => null,
          )?["items"] ??
          [];
      return appItems
          .map(
            (item) => App(
              id: item["bundleId"],
              name: item["title"],
              category: categoriesMap[item["title"]] ?? "Unknown",
              developerName: item["developerName"],
              rating: double.tryParse(item["rating"].toString()) ?? 0,
              imageUrl: (item["icon"]["template"] as String)
                  .replaceAll("{w}x{h}{c}.{f}", "512x0w.png"),
              url: item["clickAction"]["pageUrl"],
              platform: AppPlatform.ios,
              isFree: item["offerDisplayProperties"]["isFree"],
            ),
          )
          .toList();
    } catch (e) {
      dPrint("Exception while parsing iOS apps $e");
    }
    return [];
  }

  static dynamic _parseScriptTagData({
    required String pageContent,
    required String scriptId,
  }) {
    int dataStart = pageContent.indexOf('id="$scriptId"');
    if (dataStart == -1) {
      dataStart = pageContent.indexOf("id=$scriptId");
    }
    dataStart = pageContent.indexOf(">", dataStart) + 1;
    final int dataEnd = pageContent.indexOf("</script", dataStart);
    final String jsonDataString = pageContent.substring(dataStart, dataEnd);
    return jsonDecode(jsonDataString);
  }

  static void dPrint(dynamic data) {
    // ignore: avoid_print
    print(data);
  }
}
