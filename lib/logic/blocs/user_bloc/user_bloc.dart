import 'package:buksam_flutter_practicum/logic/blocs/user_bloc/user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/forum_status/form_status.dart';
import '../../../data/models/user/user_model.dart';
import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initialValue()) {
    on<InsertUserEvent>(_onInsertUser);
    on<FetchUserDocIdEvent>(_onFetchUserDocId);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onInsertUser(
      InsertUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userModel.uid)
            .set(event.userModel.toJson());
        emit(state.copyWith(
            status: ForumStatus.success, userData: event.userModel));
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchUserDocId(
      FetchUserDocIdEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();
      emit(
        state.copyWith(
          status: ForumStatus.success,
          userData: UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .update(event.userModel.toUpdateJson());
      emit(state.copyWith(
          status: ForumStatus.success, userData: event.userModel));
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }
}
