import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:http/http.dart' as http;
import 'package:hyggewalls/data/data.dart';
import 'package:hyggewalls/models/photos_model.dart';
import 'package:hyggewalls/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:hyggewalls/settings.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({@required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PhotosModel> photos = new List();

  getCategoryWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.category}&per_page=30&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategoryWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: GradientColors.facebookMessenger,
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => SettingsPage()));
            },
            icon: Icon(Icons.settings,color: Colors.blue.shade900),
          ),

        ],
    title: Row(
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          " Hygge",
          style:
          TextStyle(color: Colors.blue.shade200, fontWeight: FontWeight.w800,fontSize: 18,fontFamily: 'Roboto'),
        ),
        Text(
          "Walls",
          style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.w800,fontSize: 18,fontFamily: 'Roboto'),
        )
      ],
    ),

    backgroundColor: Colors.black,
    elevation: 0.0,
    ),
      body: SingleChildScrollView(
        child: wallPaper(photos, context)
        ,
      ),
    );
  }
}
