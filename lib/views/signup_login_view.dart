import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:emergency_notifier/exceptions/firebase_auth_exception_codes.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:emergency_notifier/services/auth_service.dart';

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

  final formKey = GlobalKey<FormState>();

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
                                      passwordController.text);
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
                      Theme.of(context).brightness == Brightness.light
                          ? OutlinedButton.icon(
                              onPressed: () async {
                                try {
                                  await _auth.signInWithGoogle();
                                } on PlatformException catch (error) {
                                  var errorMessage = 'Authentication error';
                                  final String msg = error.message ?? "";
                                  if ((msg.contains('sign_in_canceled')) ||
                                      msg.contains('sign_in_failed')) {
                                    errorMessage =
                                        'Sign in failed, try again later';
                                  } else if (msg.contains('network_error')) {
                                    errorMessage =
                                        'Sign in failed due to network issue';
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _showErrorDialog(context, errorMessage);
                                } catch (error) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  const errorMessage =
                                      'Could not sign you in, please try again later.';
                                  _showErrorDialog(context, errorMessage);
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: primaryColor,
                              ),
                              label: Text(
                                'Sign ${isLogin ? 'in' : 'up'} with Google',
                                style: const TextStyle(color: primaryColor),
                              ),
                            )
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              onPressed: () async {
                                try {
                                  await _auth.signInWithGoogle();
                                } on PlatformException catch (error) {
                                  var errorMessage = 'Authentication error';
                                  final String msg = error.message ?? "";
                                  if ((msg.contains('sign_in_canceled')) ||
                                      msg.contains('sign_in_failed')) {
                                    errorMessage =
                                        'Sign in failed, try again later';
                                  } else if (msg.contains('network_error')) {
                                    errorMessage =
                                        'Sign in failed due to network issue';
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _showErrorDialog(context, errorMessage);
                                } catch (error) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  const errorMessage =
                                      'Could not sign you in, please try again later.';
                                  _showErrorDialog(context, errorMessage);
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: primaryColor,
                              ),
                              label: Text(
                                'Sign ${isLogin ? 'in' : 'up'} with Google',
                                style: const TextStyle(color: primaryColor),
                              ),
                            ),
                      const SizedBox(height: defaultPadding * 3),
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
