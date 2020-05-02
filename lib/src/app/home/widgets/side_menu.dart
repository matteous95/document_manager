import 'package:document_manager/src/app/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Document Manager',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              /*image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/ecorp.jpg'),
              ),*/
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.supervised_user_circle,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Profilo'),
            //onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Settings'),
            //onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Logout'),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          ),
        ],
      ),
    );
  }
}
