import 'package:flutter/material.dart';
import 'article_details.dart';

class ArticleListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> articles = [
    {
      "id": 1,
      "name": "Chaussures",
      "description": "Chaussures de sport",
      "price": 200,
      "quantity": 20
    },
    {
      "id": 2,
      "name": "T-shirt",
      "description": "T-shirt coton",
      "price": 50,
      "quantity": 100
    },
    {
      "id": 3,
      "name": "Pantalon",
      "description": "Pantalon slim",
      "price": 120,
      "quantity": 30
    },
  ];

  ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text('Articles', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(
                article['name'],
                style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${article['price']} FCFA',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailsScreen(article: article),
                    ),
                  );
                },
                tooltip: 'Voir détails',
              ),
            ),
          );
        },
      ),
    );
  }
}
