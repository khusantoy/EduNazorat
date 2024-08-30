import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/firebase_options.dart';

import 'features/features.dart';
import 'utils/utils.dart';

void main() async {
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.black54,
          useMaterial3: true,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.isLoading) {
              AppDialogs.showLoading(context);
            } else {
              AppDialogs.hideLoading(context);

              if (state.error != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.error.toString())),
                  );
              }
            }
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              final userRole = state.user!.role.name;
              if (userRole == "student") {
                return const UserScreen();
              } else if (userRole == 'teacher') {
                return const TeacherScreen();
              } else if (userRole == 'admin') {
                return const AdminScreen();
              }
            }
            if (state.status == AuthenticationStatus.unauthenticated) {
              return LoginScreen();
            }

            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
