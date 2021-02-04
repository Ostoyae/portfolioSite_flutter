
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_site/pages/about_me_builder_row.dart';
import 'package:mustache_template/mustache_template.dart';
import 'package:portfolio_site/utilities/common.dart';

class AboutMeBuilder extends StatelessWidget {
  AboutMeBuilder({
    Key key,
    @required this.aboutMeText,
  }) : super(key: key);

  final String aboutMeText;

  final List<String> skills = [
    "C 🌊",
    "Rust 🦀",
    "Python 🐍",
    "Csharp 🌊#️⃣",
    "Javascript 💁‍♂",
    "Html & CSS 😭",
    "Flutter 🦋",
    "React ☢",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700,
        child: Padding(
          padding: const EdgeInsets.only(left: 128, right: 128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            // body
                            height: 300,
                            constraints:
                                BoxConstraints(maxWidth: 425, minWidth: 128),
                            width:
                                (MediaQuery.of(context).size.width - 256) / 2,
                            child: Text(aboutMeText, style: Theme.of(context).textTheme.bodyText2,)),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            child: Text("Here are the languages I work in:")),
                        AboutMeSkillSet(skill: skills),
                      ],
                    ),
                    Container(
                      width: 292,
                      height: 292,
                      decoration: BoxDecoration(color: Colors.blueGrey),
                      child: Image(
                        image: AssetImage("assets/img/self_02_HD.png"),
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                  child: SizedBox(
                      width: 180,
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context).accentColor.withOpacity(.3),
                        height: 120,
                      )))
            ],
          ),
        ));
  }
}

class AboutMe extends StatefulWidget {
  const AboutMe({Key key, @required this.info, @required this.templatePath}) : super(key: key);

  final Map info;
  final String templatePath;

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  String _aboutme;

  @override
  void initState() {
    super.initState();
    CommonUtility.loadStringAsset(widget.templatePath).then((result) {
      setState(() {
        _aboutme = Template(result).renderString(widget.info);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_aboutme == null)
      return Container(
        height: 600,
        decoration: BoxDecoration(color: Colors.red),
      );
    else
      return AboutMeBuilder(aboutMeText: _aboutme);
  }

}
