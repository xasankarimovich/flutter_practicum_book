class AuthModel {
  final String name;
  final String email;
  final String password;
  final int phoneNumber;

  AuthModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
    };
  }

  AuthModel copyWith({
    String? name,
    String? email,
    String? password,
    int? phoneNumber,
  }) {
    return AuthModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  static AuthModel initialValue() => AuthModel(
        name: '',
        email: '',
        password: '',
        phoneNumber: 0,
      );
}
