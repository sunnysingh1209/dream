part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.status = FormzStatus.pure,
      this.statusGetProfile = FormzStatus.pure,
      this.name = const Name.pure(),
      this.address = const Name.pure(),
      this.state = const Name.pure(),
      this.city = const Name.pure(),
      this.pincode = const Name.pure(),
      this.dob = const Name.pure(),
      this.message = ''});

  final FormzStatus status;
  final FormzStatus statusGetProfile;
  final Name name;
  final Name address;
  final Name state;
  final Name city;
  final Name pincode;
  final Name dob;
  final String? message;

  ProfileState copyWith({
    FormzStatus? status,
    FormzStatus? statusGetProfile,
    Name? name,
    Name? address,
    Name? state,
    Name? city,
    Name? pincode,
    Name? dob,
    String? message,
  }) {
    return ProfileState(
      name: name ?? this.name,
      address: address ?? this.address,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      message: message ?? this.message,
      dob: dob ?? this.dob,
      status: status ?? this.status,
      statusGetProfile: statusGetProfile ?? this.statusGetProfile,
    );
  }

  @override
  List<Object> get props => [
        name,
        message!,
        status,
        address,
        state,
        city,
        pincode,
        dob,
        statusGetProfile
      ];
}
