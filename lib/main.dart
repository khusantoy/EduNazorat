import 'package:crm_system/blocs/auth/auth_bloc.dart';
import 'package:crm_system/services/auth_service.dart';
import 'package:crm_system/ui/screen/auth/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Dio dio;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    authService = AuthService(dio);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRM System',
        theme: ThemeData(fontFamily: "Nunito Sans"),
        home: const RegisterScreen(),
      ),
    );
  }
}
