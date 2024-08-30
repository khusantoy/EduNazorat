import 'package:get_it/get_it.dart';
import 'package:millima/data/services/services.dart';
import 'package:millima/domain/repositories.dart';
import 'package:millima/features/features.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> dependencySetUp() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // SERVICES
  getIt.registerSingleton(AuthenticationService());
  getIt.registerSingleton(LocalAuthenticationService());
  getIt.registerSingleton(UserService());
  getIt.registerSingleton(SubjectService());

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
    () => UserBloc(),
  );

  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getIt.get<AuthenticationRepository>(),
    )..add(CheckAuthStatusEvent()),
  );

  getIt.registerLazySingleton<UsersBloc>(
    () => UsersBloc(),
  );
  getIt.registerLazySingleton<GroupBloc>(
    () => GroupBloc(),
  );
  getIt.registerLazySingleton<RoomBloc>(
    () => RoomBloc(),
  );
  getIt.registerLazySingleton<TimetableBloc>(
    () => TimetableBloc(),
  );
  getIt.registerLazySingleton<SubjectBloc>(
    () => SubjectBloc(subjectService: getIt.get<SubjectService>()),
  );
}
