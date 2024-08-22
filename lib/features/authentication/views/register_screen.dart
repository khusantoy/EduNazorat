import 'package:country_code_picker/country_code_picker.dart';
import 'package:crm_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visibilityPassword = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    width: 58,
    height: 48,
    textStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.customGray,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFD8E0F0),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
  );

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
                    height: 30,
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
                            "Ro'yhatdan o'tish",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.customBlack,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Foydalanuvchi ismi",
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
                          controller: nameController,
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            hintText: "your name",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColors.customGray,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ismingizni kiriting";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Mobil Raqam",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.customGray,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.customBorderGray,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                child: CountryCodePicker(
                                  initialSelection: 'UZ',
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD8E0F0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.customBorderGray,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Raqamingizni kiriting";
                                  } else if (int.tryParse(value) == null) {
                                    return "Raqam kiriting";
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Parol yarating",
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
                          controller: passwordController,
                          obscureText: visibilityPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
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
                              Icons.visibility_outlined,
                              color: AppColors.customGray,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Parol yarating";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Parolni tasdiqlang",
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
                          controller: confirmPasswordController,
                          obscureText: visibilityPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customBorderGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
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
                              Icons.visibility_outlined,
                              color: AppColors.customGray,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Parolni tasdiqlang";
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              return "Parol mos emas";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 35,
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
                              // final String name = nameController.text;
                              // final String phone = phoneController.text;
                              // final String password = passwordController.text;
                              // final String passwordConfirmation =
                              //     confirmPasswordController.text;

                              if (_formKey.currentState!.validate()) {}
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ro'yhatdan o'tish",
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
                            onPressed: () {},
                            child: const Text(
                              "Kirish",
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
      ),
    );
  }
}
