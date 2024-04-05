library developer_app_list;

import 'package:developer_app_list/app.dart';
import 'package:developer_app_list/util.dart';

void main() async {
  final List<App> apps = await Util.getIosApps("id1059226484");
  for (App app in apps) {
    print(app);
  }
}
