import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  BettingCubit({UserRepository? userRepository, RouteArguments? routeArguments})
      : this._userRepository = userRepository!,
        this._routeArguments = routeArguments!,
        super(BettingInitial());

  final UserRepository _userRepository;
  final RouteArguments _routeArguments;
}
