import 'package:flutter/material.dart';
import '../../utils/article_manager.dart';
import 'article_form_admin.dart';

class ArticleListAdminScreen extends StatefulWidget {
  const ArticleListAdminScreen({super.key});

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Text(
          'Gestion des Articles',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: articles.isEmpty
          ? const Center(
        child: Text(
          'Aucun article pour le moment.',
          style: TextStyle(color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (_, i) {
          final a = articles[i];
          return Card(
            color: Colors.white,
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[900],
                child: Text(
                  a.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                a.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                'Prix: ${a.price} FCFA',
                style: const TextStyle(color: Colors.black87),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black87),
                    onPressed: () => openForm(article: a),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Confirmer la suppression',
                          style: TextStyle(color: Colors.black),
                        ),
                        content: Text(
                          'Supprimer "${a.name}" ?',
                          style: const TextStyle(color: Colors.black87),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Annuler',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteArticle(a.id);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Supprimer',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
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
        backgroundColor: Colors.red[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
