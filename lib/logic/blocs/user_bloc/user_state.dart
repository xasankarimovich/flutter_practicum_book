import '../../../data/models/forum_status/form_status.dart';
import '../../../data/models/user/user_model.dart';

class UserState {
  final String errorMessage;
  final UserModel userData;
  final ForumStatus status;

  UserState(
      {required this.errorMessage,
      required this.userData,
      required this.status});

  UserState copyWith({
    String? errorMessage,
    UserModel? userData,
    ForumStatus? status,
  }) =>
      UserState(
        errorMessage: errorMessage ?? this.errorMessage,
        userData: userData ?? this.userData,
        status: status ?? this.status,
      );

  static UserState initialValue() => UserState(
        errorMessage: '',
        userData: UserModel.initialValue(),
        status: ForumStatus.initial,
      );
}
