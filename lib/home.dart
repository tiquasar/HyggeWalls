import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:hyggewalls/data/data.dart';
import 'package:hyggewalls/settings.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:hyggewalls/models/category_model.dart';
import 'package:hyggewalls/models/photos_model.dart';
import 'package:hyggewalls/view/category_screen.dart';
import 'package:hyggewalls/view/search_view.dart';
import 'package:hyggewalls/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  List<CategoryModel> categories = new List();

  int noOfImageToLoad = 10;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(

        "https://api.pexels.com/v1/search?query=nature&per_page=80&page=1",

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

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();

      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: ()  {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(

                  )));
        },
    label: Text('Refresh',
        style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Montserrat'),
    ),
    icon: Icon(Icons.refresh,color: Colors.black54),
    backgroundColor: Colors.lightBlue.shade400,
    ),
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 18,vertical:5),
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search Wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),

              ),

              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        category: categories[index].categoryName,
                      );
                    }),
              ),
              wallPaper(photos, context),
              SizedBox(
                height: 19,
              ),

              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "\nWALLPAPERS PROVIDED BY ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto'),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(

                        child: Text(
                          "\nPEXELS",
                          style: TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto'),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, category;

  CategoriesTile({@required this.imgUrls, @required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                      category: category,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 50,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        category ?? "category",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Overpass'),
                      ))
                ],
              ),
      ),
    );
  }

}


