import 'package:bloc/bloc.dart';
import 'package:dream_game/model/name.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void doUpdate(){

  }
}
