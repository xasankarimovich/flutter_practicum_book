import 'package:buksam_flutter_practicum/data/models/user/user_model_constants.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String fcmToken;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json[UserModelConstants.name] as String? ?? '',
        email: json[UserModelConstants.email] as String? ?? '',
        password: json[UserModelConstants.password] as String? ?? '',
        uid: json[UserModelConstants.uid] as String? ?? '',
        fcmToken: json[UserModelConstants.fcmToken] as String? ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      UserModelConstants.uid: uid,
      UserModelConstants.name: name,
      UserModelConstants.email: email,
      UserModelConstants.password: password,
      UserModelConstants.fcmToken: fcmToken,
    };
  }

  Map<String, dynamic> toUpdateJson() => {
        UserModelConstants.name: name,
        UserModelConstants.email: email,
        UserModelConstants.password: password,
        UserModelConstants.uid: uid,
        UserModelConstants.fcmToken: fcmToken,
      };

  UserModel copyWith({
    String? uid,
    String? fcmToken,
    String? name,
    String? email,
    String? password,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        fcmToken: fcmToken ?? this.fcmToken,
        uid: uid ?? this.uid,
      );

  static UserModel initialValue() => UserModel(
        name: '',
        email: '',
        password: '',
        fcmToken: '',
        uid: '',
      );
}
