import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);
      loginUsuario(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Este e-mail já está em uso';
      } else if (e.code == 'weak-password') {
        return 'Sua senha deve conter no mínimo 6 caracteres';
      } else if (e.code == 'invalid-email') {
        return 'Email inválido';
      }

      return 'Erro desconhecido';
    }
  }

  Future<String?> loginUsuario(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if(e.code == 'invalid-email') {
        return 'Email inválido';
      } else if (e.code == 'invalid-credential'){
        return 'Email ou senha inválidos';
      }
      return 'Erro desconhecido';
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String?> singInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _firebaseAuth.signInWithPopup(googleAuthProvider);
      return null;
    } on FirebaseAuthException catch (e) {
      return (e.message);
    }
  }
}
