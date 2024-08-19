import 'package:crm_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool visibilityPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Klaviatura ochilganda tepaga scroll qilish
      backgroundColor: AppColors.customBlueWhiter,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/company_logo.svg"),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Woorkroom",
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
                          "Sign In to Woorkroom",
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
                        "Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.customGray,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            hintText: "youremail@gmail.com",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColors.customGray,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.customGray,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
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
                            suffixIcon: const Icon(
                              Icons.visibility,
                              color: AppColors.customGray,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.check_box_outline_blank),
                              ),
                              const Text(
                                "Remember me",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.customBlack,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.customGray,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 45,
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
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign In",
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
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.customBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
