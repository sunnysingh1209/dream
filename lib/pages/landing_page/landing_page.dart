import 'package:dream_game/helper/app_config.dart' as config;
import 'package:dream_game/pages/home/view/home_page.dart';
import 'package:dream_game/pages/profile/view/profile_page.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomePage(
          parentKey: widget._scaffoldKey,
        );
      case 1:
        return new ProfilePage(
          parentKey: widget._scaffoldKey,
        );

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: config.AppColors().appbarBackColor(1.0)),
              accountName: Text(
                "Pinkesh Darji",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: config.FontFamily().book,
                ),
              ),
              accountEmail: Text(
                "pinkesh.earth@gmail.com",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: config.FontFamily().book,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            createDrawerBodyItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () {
                  _onSelectItem(0);
                }),
            createDrawerBodyItem(
                icon: Icons.currency_bitcoin,
                text: 'Transaction',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.gamepad,
                text: 'Game Result',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.person,
                text: 'Profile',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.feedback,
                text: 'Rate Us',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.share,
                text: 'Share',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.headphones,
                text: 'Contact Us',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.quick_contacts_dialer,
                text: 'Terms & Conditions',
                onTap: () {
                  _onSelectItem(1);
                }),
            createDrawerBodyItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  context.read<AuthenticationRepository>().logOut();
                }),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

Widget createDrawerBodyItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    leading: Icon(
      icon,
      size: 30,
      color: config.AppColors().drawerItemBackColor(1.0),
    ),
    title: Text(text!,
        style: TextStyle(
            color: config.AppColors().drawerItemBackColor(1.0),
            fontSize: 20,
            fontWeight: config.FontFamily().medium)),
    onTap: onTap,
  );
}
