import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/auth/login_request.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32.0),
                FilledButton(
                  onPressed: () {
                    // Handle login logic
                    final phone = _phoneController.text;
                    final password = _passwordController.text;

                    context.read<AuthenticationBloc>().add(LoginEvent(
                          request: LoginRequest(
                            phone: phone,
                            password: password,
                          ),
                        ));
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to register screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () async {
                    context
                        .read<AuthenticationBloc>()
                        .add(SocialLoginEvent(type: SocialLoginTypes.google));
                  },
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.facebook,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Google'),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(SocialLoginEvent(type: SocialLoginTypes.facebook));
                  },
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.facebook,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Facebook'),
                      )
                    ],
                  ),
                ),
                // const SizedBox(height: 10),
                // OutlinedButton(
                //   onPressed: () {
                //     // Handle login logic
                //     final phone = _phoneController.text;
                //     final password = _passwordController.text;

                //     context.read<AuthenticationBloc>().add(LoginEvent(
                //           request: LoginRequest(
                //             phone: phone,
                //             password: password,
                //           ),
                //         ));
                //   },
                //   child: const Stack(
                //     children: [
                //       Align(
                //         alignment: Alignment.centerLeft,
                //         child: Icon(
                //           Icons.facebook,
                //         ),
                //       ),
                //       Align(
                //         alignment: Alignment.center,
                //         child: Text('Github'),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
