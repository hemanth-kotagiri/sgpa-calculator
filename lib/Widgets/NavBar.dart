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
            accountEmail: Row(
              children: [
                TextButton(
                  child: Image.asset(
                    "assets/images/Octocat.png",
                  ),
                  onPressed: () {
                    _launchURL("https://github.com/hemanth-kotagiri");
                  },
                ),
                TextButton(
                  child: Image.asset(
                    "assets/images/linkedin.png",
                    width: 20,
                  ),
                  onPressed: () {
                    _launchURL("https://www.linkedin.com/in/hemanth-kotagiri/");
                  },
                ),
                TextButton(
                  child: Image.asset(
                    "assets/images/instagram.png",
                    width: 20,
                  ),
                  onPressed: () {
                    _launchURL("https://www.instagram.com/hemanth_43/");
                  },
                ),
                TextButton(
                  child: Image.asset(
                    "assets/images/medium.png",
                    width: 20,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    _launchURL("https://medium.com/@hemanth-kotagiri43");
                  },
                ),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/24365579?v=4"),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.code_rounded,
              color: Colors.white,
            ),
            title: Text("Open Source App"),
            subtitle: Text("Tap to go to repository"),
            onTap: () {
              _launchURL("https://github.com/hemanth-kotagiri/sgpa-calculator");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text("Hemanth Kotagiri"),
            subtitle: Text("Developer"),
            onTap: () {
              _launchURL("https://github.com/hemanth-kotagiri");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.white,
            ),
            title: Text("Email"),
            subtitle: Text("hemanth.kotagiri43@gmail.com"),
          ),
          ListTile(
            leading: Icon(
              Icons.animation,
              color: Colors.white,
            ),
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
