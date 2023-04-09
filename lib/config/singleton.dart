import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './singleton.config.dart';

final singleton = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async =>
    singleton.init(environment: Environment.dev);
