import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/home/settings_form.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew_crew/home/brew_list.dart';
import 'package:ninja_brew_crew/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Brew Crew'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(onPressed: () async {
                _auth.signOut();
              },
                  icon: Icon(Icons.person,
                  color: Colors.white),
                      label: Text('Log Out',
                      style: TextStyle(color: Colors.white))
              ),
              TextButton.icon(
                  onPressed: () {
                  _showSettingsPanel();
              }, icon: Icon(Icons.settings, color: Colors.white,),
                  label: Text('Settings',
                  style: TextStyle(color: Colors.white),)
              )
            ],
          ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit:  BoxFit.cover
            )
          ),
            child: BrewList()),
      ),
    );
  }
}
