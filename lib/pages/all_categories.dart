import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../models/show_category.dart';
import '../services/show_category_news.dart';
import 'web_view.dart';

class AllCategoriesNews extends StatefulWidget {
  @override
  State<AllCategoriesNews> createState() => _AllCategoriesNewsState();
}

class _AllCategoriesNewsState extends State<AllCategoriesNews> {
  List<ShowCategoryModel> allCategoriesNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchAllCategoriesNews();
  }

  fetchAllCategoriesNews() async {
    List<String> categories = ["business", "entertainment", "general", "health", "sports"];
    for (String category in categories) {
      ShowCategoryNews showCategoryNews = ShowCategoryNews();
      await showCategoryNews.getCategoriesNews(category);
      allCategoriesNews.addAll(showCategoryNews.categories);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tin tức về Mỹ",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: allCategoriesNews.length,
          itemBuilder: (context, index) {
            return ShowCategory(
              image: allCategoriesNews[index].urlToImage ?? '',
              desc: allCategoriesNews[index].description ?? '',
              title: allCategoriesNews[index].title ?? '',
              url: allCategoriesNews[index].url ?? '',
            );
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  ShowCategory({required this.image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
