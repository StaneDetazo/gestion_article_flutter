import 'package:flutter/material.dart';
import '../../utils/article_manager.dart';
import 'article_form_admin.dart';

class ArticleListAdminScreen extends StatefulWidget {
  @override
  State<ArticleListAdminScreen> createState() => _ArticleListAdminScreenState();
}

class _ArticleListAdminScreenState extends State<ArticleListAdminScreen> {
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

  void openForm({Article? article}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ArticleFormAdminScreen(article: article)),
    );
    if (result == true) {
      loadArticles();
    }
  }

  void deleteArticle(int id) async {
    await ArticleManager.deleteArticle(id);
    await loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Articles'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (_, i) {
          final a = articles[i];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(a.name),
              subtitle: Text('Prix: ${a.price} FCFA'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => openForm(article: a),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Confirmer suppression'),
                        content: Text('Supprimer "${a.name}" ?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Annuler')),
                          TextButton(
                              onPressed: () {
                                deleteArticle(a.id);
                                Navigator.pop(context);
                              },
                              child: Text('Supprimer')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
