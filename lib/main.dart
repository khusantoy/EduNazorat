import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/features/authentication/views/login_screen.dart';
import 'package:crm_system/features/authentication/views/register_screen.dart';
import 'package:crm_system/features/home/views/home_screen.dart';
import 'package:crm_system/features/user/bloc/user_bloc.dart';
import 'package:crm_system/firebase_options.dart';
import 'package:crm_system/utils/locator.dart';
import 'package:crm_system/utils/providers.dart';
import 'package:crm_system/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'utils/helpers/dialogs.dart';

void main() async {

  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dependencySetUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
          routes: {
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
          },
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.isLoading) {
                  AppDialogs.showLoading(context);
                } else {
                  AppDialogs.hideLoading(context);

                  if (state.error != null) {
                    Map<String, dynamic> error =
                        state.error as Map<String, dynamic>;

                    String errorMessage = '';

                    if (error['data'].containsKey('password')) {
                      errorMessage = error['data']['password'][0];
                    } else if (error['data']
                        .containsKey('password_confirmation')) {
                      errorMessage = error['data']['password_confirmation'][0];
                    } else if (error['data'].containsKey('phone')) {
                      errorMessage = error['data']['phone'][0];
                    } else if (error['data'].containsKey('error')) {
                      errorMessage = error['data']['error'];
                    }

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                  }
                }

                if (state.status == AuthenticationStatus.authenticated) {
                  context.read<UserBloc>().add(GetCurrentUserEvent());
                }
              },
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return const HomeScreen();
                }

                return const LoginScreen();
              },
            ),
          )),
    );
  }
}
