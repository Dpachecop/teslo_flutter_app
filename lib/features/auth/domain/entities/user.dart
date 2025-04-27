class User {
  final String email;
  final String id;
  final String fullName;
  final String token;
  final List<String> roles;

  User({
    required this.email,
    required this.id,
    required this.fullName,
    required this.token,
    required this.roles,
  });

  bool get isAdmin => roles.contains('admin');
}
