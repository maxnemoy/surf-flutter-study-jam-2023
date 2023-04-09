// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/repository/i_ticket_repository.dart'
    as _i5;
import 'package:surf_flutter_study_jam_2023/services/local_storage/i_local_storage.dart'
    as _i3;
import 'package:surf_flutter_study_jam_2023/services/navigation/i_navigation_service.dart'
    as _i4;

const String _dev = 'dev';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ILocalStorage>(
      _i3.LocalStorage(),
      registerFor: {_dev},
    );
    gh.singleton<_i4.INavigationService>(
      _i4.NavigationService(),
      registerFor: {_dev},
    );
    gh.singleton<_i5.ITicketRepository>(
      _i5.TicketRepository(),
      registerFor: {_dev},
    );
    return this;
  }
}
