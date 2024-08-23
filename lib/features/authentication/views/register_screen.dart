import 'package:crm_system/data/models/auth/register_request.dart';
import 'package:crm_system/features/authentication/bloc/authentication_bloc.dart';
import 'package:crm_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visibilityPassword = true;
  bool visibilityPasswordConfimation = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int _selectedRoleIndex = 1;
  final List<String> _roles = [
    'Student',
    'Teacher',
    'Admin',
  ];

  @override
  void initState() {
    super.initState();
    phoneController.text = "+998";
  }

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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                              hintText: "Ismingiz",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColors.customGray,
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                          TextFormField(
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
                              hintText: "+998 90 000 00 00",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColors.customGray,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: AppColors.customBorderGray,
                                ),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Raqamingizni kiriting";
                              } else if (int.tryParse(value) == null) {
                                return "Raqam kiriting";
                              }
                              return null;
                            },
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            obscureText: visibilityPasswordConfimation,
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibilityPasswordConfimation =
                                        !visibilityPasswordConfimation;
                                  });
                                },
                                icon: Icon(
                                  visibilityPasswordConfimation
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.customGray,
                                ),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                          StatefulBuilder(builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Maqomingizni tanlang",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.customGray,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                DropdownButtonFormField<int>(
                                  value: _selectedRoleIndex,
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
                                  ),
                                  items: [
                                    for (var index = 0;
                                        index < _roles.length;
                                        index++)
                                      DropdownMenuItem<int>(
                                        value: index + 1,
                                        child: Text(_roles[index]),
                                      )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRoleIndex = value!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.customBlue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      final String name = nameController.text;
                                      final String phone = phoneController.text;
                                      final String password =
                                          passwordController.text;
                                      final String passwordConfirmation =
                                          confirmPasswordController.text;
                                      final role = _selectedRoleIndex;

                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthenticationBloc>().add(
                                              RegisterEvent(
                                                request: RegisterRequest(
                                                  name: name,
                                                  phone: phone,
                                                  password: password,
                                                  passwordConfirmation:
                                                      passwordConfirmation,
                                                  roleId: role,
                                                ),
                                              ),
                                            );
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
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
      ),
    );
  }
}
