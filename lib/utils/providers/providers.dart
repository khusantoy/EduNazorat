import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

import '../di/locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
  BlocProvider<UsersBloc>.value(value: getIt.get<UsersBloc>()),
  BlocProvider<GroupBloc>.value(value: getIt.get<GroupBloc>()),
  BlocProvider<RoomBloc>.value(value: getIt.get<RoomBloc>()),
  BlocProvider<TimetableBloc>.value(value: getIt.get<TimetableBloc>()),
  BlocProvider<SubjectBloc>.value(value: getIt.get<SubjectBloc>()),
];
