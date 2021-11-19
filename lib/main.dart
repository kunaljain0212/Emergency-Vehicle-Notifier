import 'package:emergency_notifier/common/routes.dart';
import 'package:emergency_notifier/common/theme.dart';
import 'package:emergency_notifier/views/wrappers/auth_wrapper.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/services/auth_service.dart';
import 'package:emergency_notifier/views/signup_login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthModel?>(
          initialData: null,
          create: (_) => AuthService().user,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Muzzle',
        theme: lightThemeData,
        // darkTheme: darkThemeData,
        routes: {
          MyRoutes.landing: (context) => const Wrapper(),
          MyRoutes.signUpLogin: (context) => const SignUpLoginView(),
        },
      ),
    );
  }
}
