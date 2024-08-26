import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/features/user/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
];
