import 'package:developer_app_list/developer_app_list.dart';
import 'package:developer_app_list/models/app.dart';
import 'package:developer_app_list/util/util.dart';

void main() async {
  final List<App> iosApps = await DeveloperAppList.getIosApps(
    developerId: "id1671444635",
  );
  Util.dPrint(iosApps);
}
