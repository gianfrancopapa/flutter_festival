import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/firebase_options.dart';
import 'package:webapp/login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  bootstrap(
    () async {
      //Initialize dependencies
      final authenticationRepository = AuthenticationRepository(
        authService: FirebaseAuth.instance,
      );

      return FlutterFestivalApp(
        authenticationRepository: authenticationRepository,
      );
    },
  );
}

void bootstrap(Future<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(await builder());
}

class FlutterFestivalApp extends StatelessWidget {
  const FlutterFestivalApp({
    required this.authenticationRepository,
    Key? key,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Festival Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const LoginView(),
      ),
    );
  }
}
