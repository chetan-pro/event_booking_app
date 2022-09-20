class LoginUser {
  static LoginUser? _instance;
  int? userId;
  String? userName;
  String? email;
  LoginUser._(String? userName, String? email, int? userId);

  factory LoginUser(
      {required String userName, required String email, required int userId}) {
    _instance ??= LoginUser._(userName, email, userId);
    return _instance!;
  }

  static LoginUser? get shared => _instance;
}
