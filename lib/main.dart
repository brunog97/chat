import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/screens/auth.screen.dart';
import 'package:personal_expenses/screens/chat.screen.dart';

void main() async {
  // Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (ctx, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, //Remove a faixa "debug"
          title: 'Despesas Pessoais',
          theme: ThemeData(
            primarySwatch: Colors.pink, //Cor primaria do app
            backgroundColor: Colors.pink, //Cor de fundo do app
            accentColor: Colors.deepPurple, //Cor secundaria do app
            accentColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? Center(child: Text('Aguarde'))
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.hasData) {
                      return ChatScreen();
                    } else {
                      return AuthScreen();
                    }
                  },
                ),
          //AuthScreen(),
        );
      },
    );
  }
}
