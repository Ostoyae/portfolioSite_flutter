import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _constructSideBar(context);
  }

  Widget _constructSideBar(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width - 90,
        top: MediaQuery.of(context).size.height / 2 - 200,
        child: Container(
          width: 90,
          height: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createLinkedIcon(
                  uri: "https://github.com/ostoyae/",
                  icon: FontAwesome5.github_alt),

              createLinkedIcon(
                  uri: "https://linkedin.com/in/rustyboy",
                  icon: FontAwesome5.linkedin_in),
              createLinkedIcon(
                  uri: "https://twitter.com/_ostoyae",
                  icon: FontAwesome5.twitter),
              createLinkedIcon(
                  uri: "https://medium.com/@Ostoyae",
                  icon: FontAwesome5.medium_m),
            ],
          ),
        ));
  }

  Widget createLinkedIcon(
      {String uri,
      LinkTarget target: LinkTarget.blank,
      IconData icon,
      Color color}) {
    Link iconButton = Link(
        uri: Uri.parse(uri),
        target: target,
        builder: (_, followLink) => IconButton(
            icon: Icon(
              icon,
              color: color ?? Colors.white.withOpacity(0.9),
            ),
            onPressed: () => followLink()));

    return iconButton;
  }
}
