import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;

class CommonProgressWidget extends StatelessWidget {
  const CommonProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: config.AppConfig(context).appHeight(100),
        width: config.AppConfig(context).appWidth(100),
        child: Center(
          child: CupertinoActivityIndicator(
            radius: 10,
            color: Theme.of(context).hintColor,
          ),
        ));
  }
}
