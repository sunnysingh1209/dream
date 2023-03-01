part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.address = const Name.pure(),
    this.state = const Name.pure(),
    this.city = const Name.pure(),
    this.pincode = const Name.pure(),
    this.dob = const Name.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Name address;
  final Name state;
  final Name city;
  final Name pincode;
  final Name dob;

  ProfileState copyWith({
    FormzStatus? status,
    Name? name,
    Name? address,
    Name? state,
    Name? city,
    Name? pincode,
    Name? dob,
  }) {
    return ProfileState(
      name: name ?? this.name,
      address: address ?? this.address,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      dob: dob ?? this.dob,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, status, address, state, city, pincode, dob];
}
