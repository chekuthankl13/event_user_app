abstract class UserParam {
  final String email;
  final String password;

  UserParam({required this.email, required this.password});
}

abstract class UserParam2 {
  final String email;
  final String password;
  final String phone;
  final String name;

  UserParam2({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });
}
