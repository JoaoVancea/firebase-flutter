import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_cadastro/ui/pages/HomePage.dart';
import 'package:login_cadastro/ui/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends MaterialApp{
   const MyApp({super.key}) : super(home: const RoteadorTela(), debugShowCheckedModeBanner: false);
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(), builder: (context, snapshot) {
      if(snapshot.hasData){
        return HomePage();
      } else {
        return Login();
      }
    },);
  }
}