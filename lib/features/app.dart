import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/app_config.dart';
import 'package:surf_flutter_study_jam_2023/services/export.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, extensions: [
        CustomListTileTheme(
          titleTextStyle: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          subTitleTextStyle: TextStyle(
              color: Colors.grey.withOpacity(.9),
              fontSize: 14,
              fontWeight: FontWeight.bold),
          leadingIconStyle: IconThemeData(color: Colors.grey.withOpacity(.6)),
          trailingIconStyle:
              IconThemeData(color: Colors.deepPurple.withOpacity(.9)),
        )
      ]),
      routerConfig: singleton.get<INavigationService>().router,
      scaffoldMessengerKey: singleton.get<INavigationService>().massagerKey,
    );
  }
}
