import 'package:equatable/equatable.dart';

import '../../../data/models/user/user_model.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class InsertUserEvent extends UserEvent {
  final UserModel userModel;

  const InsertUserEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class FetchUserDocIdEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserModel userModel;

  const UpdateUserEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}
