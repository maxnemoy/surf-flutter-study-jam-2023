import 'package:surf_flutter_study_jam_2023/features/app.dart';

import 'config/app_config.dart';

void main() {
  AppWrapper app = AppWrapper(initializers: [configureDependencies]);
  app.runApplication(const BlocWrapper(child: App()));
}
