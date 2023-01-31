import 'package:dream_game/app.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('configuration');

  runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository()));
}
