import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'article_view.dart';

class SearchScreen extends StatefulWidget {
  final List<ArticleModel> articles;

  SearchScreen({required this.articles});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ArticleModel> filteredArticles = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredArticles = [];  // Initialize as empty list
  }

  void _filterArticles(String query) {
    List<ArticleModel> filtered = widget.articles
        .where((article) =>
    article.title!.toLowerCase().contains(query.toLowerCase()) ||
        article.description!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredArticles = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            border: InputBorder.none,
          ),
          onChanged: (query) => _filterArticles(query),
        ),
      ),
      body: filteredArticles.isEmpty
          ? Center(
        child: Text(
          'Nhập từ khóa để tìm kiếm',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: filteredArticles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredArticles[index].title!),
            subtitle: Text(filteredArticles[index].description!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleView(
                    blogUrl: filteredArticles[index].url!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
