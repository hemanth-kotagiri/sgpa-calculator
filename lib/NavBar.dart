import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("© Hemanth Kotagiri"),
            accountEmail: Text("hemanth.kotagiri43@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/24365579?v=4"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.code_rounded),
            title: Text("Open Source App"),
            subtitle: Text("Tap to go to repository"),
            onTap: () {
              _launchURL("https://github.com/hemanth-kotagiri/sgpa-calculator");
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Hemanth Kotagiri"),
            subtitle: Text("Developer"),
            onTap: () {
              _launchURL("https://github.com/hemanth-kotagiri");
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text("hemanth.kotagiri43@gmail.com"),
          ),
          ListTile(
            leading: Icon(Icons.animation),
            title: Text("License"),
            subtitle: Text("MIT"),
          ),
          ListTile(
            title: Text("Made with ❤️ by Hemanth"),
          ),
        ],
      ),
    );
  }
}
