class UserModel {
  String name;
  String email;
  String password;

  UserModel({required this.name,required this.email, required this.password});

  @override
  String toString() {
    return "nome: $name";
  }
}
