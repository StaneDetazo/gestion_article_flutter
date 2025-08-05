import 'package:flutter/material.dart';
import 'article_details.dart';

class ArticleListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> articles = [
    {"id": 1, "name": "Chaussures", "description": "Chaussures de sport", "price": 200, "quantity": 20},
    {"id": 2, "name": "T-shirt", "description": "T-shirt coton", "price": 50, "quantity": 100},
    {"id": 3, "name": "Pantalon", "description": "Pantalon slim", "price": 120, "quantity": 30},
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

/*
* import 'package:flutter/material.dart';
import '../../utils/article_manager.dart';
import 'article_details.dart';

class ArticleListScreen extends StatefulWidget {
  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  Future<void> loadArticles() async {
    final loaded = await ArticleManager.loadArticles();
    setState(() {
      articles = loaded;
    });
  }

  void addToCart(Article article) {
    // À adapter selon ta logique de panier (SharedPreferences ou local list)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${article.name} ajouté au panier')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles disponibles')),
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(article.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${article.price} FCFA'),
                  const SizedBox(height: 4),
                  Text(article.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                    onPressed: () => addToCart(article),
                    tooltip: 'Ajouter au panier',
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailsScreen(
                            article: {
                              'id': article.id,
                              'name': article.name,
                              'description': article.description,
                              'price': article.price,
                            },
                          ),
                        ),
                      );
                    },
                    tooltip: 'Voir détails',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

* */
