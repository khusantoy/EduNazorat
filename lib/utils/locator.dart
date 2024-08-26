import 'package:crm_system/data/services/authentication/authentication_service.dart';
import 'package:crm_system/data/services/authentication/local_authentication_service.dart';
import 'package:crm_system/data/services/user/user_service.dart';
import 'package:crm_system/domain/authentication_repository/authentication_repository.dart';
import 'package:crm_system/domain/user_repository/user_repository.dart';
import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/features/user/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> dependencySetUp() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // SERVICES
  getIt.registerSingleton(AuthenticationService());
  getIt.registerSingleton(LocalAuthenticationService());
  getIt.registerSingleton(UserService());

  // REPOSITORIES
  getIt.registerSingleton(
    AuthenticationRepository(
      authenticationService: getIt.get<AuthenticationService>(),
      localAuthenticationService: getIt.get<LocalAuthenticationService>(),
    ),
  );
  getIt.registerSingleton(
    UserRepository(
      userService: getIt.get<UserService>(),
    ),
  );
 
  // BLOCS
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(
      userRepository: getIt.get<UserRepository>(),
    ),
  );

  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getIt.get<AuthenticationRepository>(),
    )..add(CheckAuthStatusEvent()),
  );
}
