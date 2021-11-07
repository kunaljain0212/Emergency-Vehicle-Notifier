import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emergency_notifier/exceptions/firebase_auth_exception_codes.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:emergency_notifier/services/auth_service.dart';

enum UserType { driver, user }

void _showErrorDialog(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.error_outline,
          size: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: primaryColor,
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

class SignUpLoginView extends StatefulWidget {
  const SignUpLoginView({Key? key}) : super(key: key);

  @override
  _SignUpLoginViewState createState() => _SignUpLoginViewState();
}

class _SignUpLoginViewState extends State<SignUpLoginView> {
  final AuthService _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hospitalNameController = TextEditingController();
  final vehicleNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UserType? userType = UserType.user;
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Image.asset('assets/images/logo.png', height: 150),
                      const SizedBox(height: defaultPadding),
                      isLogin
                          ? Container()
                          : TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                hintText: 'Enter you full name',
                                labelText: 'Name',
                              ),
                            ),
                      isLogin
                          ? Container()
                          : const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          bool isEmailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? '');
                          if (!isEmailValid) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Enter you email',
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if ((value?.length ?? 8) < 7) {
                            return 'Password must be 7 characters long';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter you password',
                          labelText: 'Password',
                          suffixIcon: passwordController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: secondaryTextColorDarkTheme,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: secondaryTextColorDarkTheme,
                                        ),
                                ),
                        ),
                      ),
                      !isLogin && userType == UserType.driver
                          ? const SizedBox(height: defaultPadding)
                          : Container(),
                      !isLogin && userType == UserType.driver
                          ? TextFormField(
                              controller: hospitalNameController,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter hospital name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                hintText: 'Enter hospital name',
                                labelText: 'Hospital Name',
                              ),
                            )
                          : Container(),
                      !isLogin && userType == UserType.driver
                          ? const SizedBox(height: defaultPadding)
                          : Container(),
                      !isLogin && userType == UserType.driver
                          ? TextFormField(
                              controller: vehicleNumberController,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter vehicle number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                hintText: 'Enter your vehicle number',
                                labelText: 'Vehicle Number',
                              ),
                            )
                          : Container(),
                      isLogin
                          ? Container()
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: const Text('User'),
                                    leading: Radio<UserType>(
                                      value: UserType.user,
                                      groupValue: userType,
                                      onChanged: (UserType? value) {
                                        setState(() {
                                          userType = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Driver'),
                                    leading: Radio<UserType>(
                                      value: UserType.driver,
                                      groupValue: userType,
                                      onChanged: (UserType? value) {
                                        setState(() {
                                          userType = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: defaultPadding * 3),
                      ElevatedButton(
                        onPressed: () async {
                          final isValid = formKey.currentState?.validate();
                          if (isValid ?? true) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              isLogin
                                  ? await _auth.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text)
                                  : await _auth.signUpWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                      userType == UserType.driver
                                          ? 'driver'
                                          : 'user',
                                      hospitalNameController.text,
                                      vehicleNumberController.text,
                                    );
                            } on FirebaseAuthException catch (error) {
                              setState(() {
                                isLoading = false;
                              });
                              final String errorMessage =
                                  getMessageFromErrorCode(error);
                              _showErrorDialog(
                                context,
                                errorMessage,
                              );
                            }
                          }
                        },
                        child: Text('Sign ${isLogin ? 'in' : 'up'}'),
                      ),
                      const SizedBox(height: defaultPadding),
                      Divider(
                        color: Theme.of(context).brightness == Brightness.light
                            ? secondaryColorDarkTheme
                            : secondaryTextColorDarkTheme,
                        endIndent: 125,
                        indent: 125,
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLogin
                                ? 'Not signed in yet?'
                                : 'Already signed up?',
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              'Sign ${isLogin ? 'up' : 'in'}',
                              style: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
