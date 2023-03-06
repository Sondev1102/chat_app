import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.pink,
            onPrimary: Colors.white,
            secondary: Colors.deepPurple,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.pink,
            onBackground: Colors.pink,
            surface: Colors.black,
            onSurface: Colors.black,
          ),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.data == null || snapshot.data!.uid.isEmpty) {
              print('auth');

              return AuthScreen();
            }
            print(snapshot.data);
            print('chat');
            return ChatScreen();
          }),
        )
        // FutureBuilder(
        //   future: Firebase.initializeApp(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return const Scaffold(
        //         body: Center(
        //           child: Text('Something went wrong!'),
        //         ),
        //       );
        //     }

        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return ;
        //     }
        //     return const Scaffold(
        //       body: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
