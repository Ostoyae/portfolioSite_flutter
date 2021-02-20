import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mustache_template/mustache_template.dart';
import 'package:portfolio_site/utilities/common.dart';

import 'about_me_builder_row.dart';

class AboutMe extends StatefulWidget {
  final Map info;

  final String templatePath;
  final Size size;

  const AboutMe(
      {Key key, @required this.info, @required this.templatePath, this.size})
      : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class AboutMeBuilder extends StatelessWidget {
  final Size size;

  final String aboutMeText;

  final List<String> skills = [
    "C 🌊",
    "Rust 🦀",
    "Python 🐍",
    "Csharp 🌊#",
    "Javascript 💁‍♂",
    "Html & CSS 😭",
    "Flutter 🦋",
    "React ☢",
  ];

  AboutMeBuilder({Key key, @required this.aboutMeText, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 900,
        padding: EdgeInsets.only(top: 80, bottom: 80),
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
            Container(
              // width: 900,
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
                          width: (MediaQuery.of(context).size.width - 256) / 2,
                          child: SelectableText(
                            aboutMeText,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                          // Text(aboutMeText, style: Theme.of(context).textTheme.bodyText2,)
                          ),
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
                      image: AssetImage("assets/img/self_02.png"),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
            Spacer(flex: 1),
            Center(
                child: SizedBox(
                    width: 180,
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).accentColor.withOpacity(.3),
                      // height: 120,
                    )))
          ],
        ));
  }
}

class _AboutMeState extends State<AboutMe> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _constructAboutMe(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.hasData) {
            return AboutMeBuilder(
              aboutMeText: snapshot.data,
              size: widget.size,
            );
          }
          return Container(
            height: 900,
            child: Center(
              child: SizedBox(
                child: Text("Fetching Data..."),
                width: 60,
                height: 60,
              ),
            ),
          );
        });
  }

  //Todo: Load from a S3 bucket.
  @override
  void initState() {
    super.initState();
  }

  Future<String> _constructAboutMe() async {
    String result = await CommonUtility.loadStringAsset(widget.templatePath);
    return Template(result).renderString(widget.info);
  }
}
