import 'package:crm_system/data/models/auth/login_request.dart';
import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibilityPassword = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = "+998";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Klaviatura ochilganda tepaga scroll qilish
      backgroundColor: AppColors.customBlueWhiter,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/company_logo.svg"),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "EduNazorat",
                        style: TextStyle(
                          color: AppColors.customBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC4CBD6).withOpacity(0.1),
                          offset: const Offset(0, 6),
                          blurRadius: 58,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Dasturga kirish",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.customBlack,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Telefon Raqam",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.customGray,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            hintText: "998 90 000 00 00",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColors.customGray,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty || value == "+998") {
                              return "Raqam kiritilmadi";
                            } else if (int.tryParse(value) == null) {
                              return "Ma'lumot xato";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Parol",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.customGray,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: visibilityPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            hintText: "••••••••",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColors.customGray,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibilityPassword = !visibilityPassword;
                                });
                              },
                              icon: Icon(
                                visibilityPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.customGray,
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Parol kiritilmadi";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.customBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final phone = _phoneController.text;
                                final password = _passwordController.text;
                                context.read<AuthenticationBloc>().add(
                                      LoginEvent(
                                        request: LoginRequest(
                                          phone: phone,
                                          password: password,
                                        ),
                                      ),
                                    );
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Kirish",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              "Ro'yhatdan o'tish",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.customBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/google.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/facebook.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/github.png",
                                width: 20,
                                height: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
