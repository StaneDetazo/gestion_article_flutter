import 'package:flutter/material.dart';
import 'article_details.dart';

class ArticleListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> articles = [
    {"id": 1, "name": "Chaussures", "description": "Chaussures de sport", "price": 200},
    {"id": 2, "name": "T-shirt", "description": "T-shirt coton", "price": 50},
    {"id": 3, "name": "Pantalon", "description": "Pantalon slim", "price": 120},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            child: ListTile(
              title: Text(article['name']),
              subtitle: Text('${article['price']} FCFA'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailsScreen(article: article),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
