import 'package:developer_app_list/developer_app_list.dart';
import 'package:developer_app_list/models/app.dart';
import 'package:developer_app_list/util/util.dart';

void main() async {
  final List<App> iosApps = await DeveloperAppList.getIosApps(
    developerId: "zipoapps/id1671444635",
  );
  Util.dPrint(iosApps);

  // final List<App> androidApps = await DeveloperAppList.getAndroidApps(
  //   developerId: "7308236621174667518",
  // );
  // Util.dPrint(androidApps);
}
