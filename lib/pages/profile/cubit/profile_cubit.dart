import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/helper.dart';
import 'package:dream_game/model/error_model.dart';
import 'package:dream_game/model/name.dart';
import 'package:dream_game/model/profile_model.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required UserRepository userRepository})
      : this._userRepository = userRepository,
        super(ProfileState());

  final UserRepository _userRepository;

  void doUpdate() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress, message: ''),
    );

    var map = Map<String, dynamic>();
    map['name'] = state.name.value.toString();
    map['address1'] = state.address.value.toString();
    map['city'] = state.city.value.toString();
    map['state'] = state.state.value.toString();
    map['pincode'] = state.pincode.value.toString();
    map['dob'] = state.dob.value.toString();
    map['address2'] = null;
    map['userImage'] = '';

    Response response = await _userRepository.updateProfile(data: map);
    if (response.statusCode == 200) {
      emit(
        state.copyWith(message: '', status: FormzStatus.submissionSuccess),
      );
      Helper.showToast('Success');
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/LandingPage', (route) => false);
    } else {
      print('Sunnny singh response  ${response.body}');
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            message: ErrorModel.fromJson(jsonDecode(response.body))
                .errors
                ?.join('\n')),
      );
    }
    emit(
      state.copyWith(status: FormzStatus.pure, message: ''),
    );
  }

  void onNameChanged({String? value}) {
    emit(
      state.copyWith(
          name: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.address,
            state.pincode,
            state.state,
            state.city,
            state.dob,
          ])),
    );
  }

  void onStateChanged({String? value}) {
    emit(
      state.copyWith(
          state: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.address,
            state.pincode,
            state.name,
            state.city,
            state.dob,
          ])),
    );
  }

  void onCityChanged({String? value}) {
    emit(
      state.copyWith(
          city: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.address,
            state.pincode,
            state.state,
            state.name,
            state.dob,
          ])),
    );
  }

  void onPinCodeChanged({String? value}) {
    emit(
      state.copyWith(
          pincode: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.address,
            state.name,
            state.state,
            state.city,
            state.dob,
          ])),
    );
  }

  void onDobChanged({String? value}) {
    emit(
      state.copyWith(
          dob: Name.dirty(value.toString() ),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.address,
            state.name,
            state.state,
            state.city,
            state.pincode,
          ])),
    );
  }

  void onAddressChanged({String? value}) {
    emit(
      state.copyWith(
          address: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.dob,
            state.name,
            state.state,
            state.city,
            state.pincode,
          ])),
    );
  }

  void setDataInAll(ProfileModel profileModel) {
    emit(state.copyWith(
        name: Name.dirty(profileModel.profileData!.name ?? ''),
        state: Name.dirty(profileModel.profileData!.state ?? ''),
        city: Name.dirty(profileModel.profileData!.city ?? ''),
        dob: Name.dirty(profileModel.profileData!.dob?.substring(0, 10) ?? ''),
        pincode: Name.dirty(profileModel.profileData!.pincode ?? ''),
        address: Name.dirty(profileModel.profileData!.address1 ?? ''),
        statusGetProfile: FormzStatus.pure));
  }

  void onGetProfile() async {
    emit(state.copyWith(statusGetProfile: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.getProfile();
    if (response.statusCode == 200) {
      ProfileModel profileModel =
          ProfileModel.fromJson(jsonDecode(response.body));
      print('SunnyModel ${profileModel}');
      emit(state.copyWith(
        statusGetProfile: FormzStatus.submissionSuccess,
      ));
      setDataInAll(profileModel);
    } else
      emit(state.copyWith(statusGetProfile: FormzStatus.submissionFailure));
  }
}

// activePlayGame: ActivePlayGame.fromJson(jsonDecode(response.body))
