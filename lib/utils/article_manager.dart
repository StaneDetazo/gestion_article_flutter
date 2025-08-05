import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Article {
  int id;
  String name;
  String description;
  int price;

  Article({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
  };

  static Article fromJson(Map<String, dynamic> json) => Article(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    price: json['price'],
  );
}

class ArticleManager {
  static const _articlesKey = 'articles';

  // Charger la liste des articles
  static Future<List<Article>> loadArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_articlesKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Article.fromJson(json)).toList();
  }

  // Sauvegarder la liste
  static Future<void> saveArticles(List<Article> articles) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(articles.map((a) => a.toJson()).toList());
    await prefs.setString(_articlesKey, jsonString);
  }

  // Ajouter un article
  static Future<void> addArticle(Article article) async {
    final articles = await loadArticles();
    articles.add(article);
    await saveArticles(articles);
  }

  // Modifier un article
  static Future<void> updateArticle(Article article) async {
    final articles = await loadArticles();
    final index = articles.indexWhere((a) => a.id == article.id);
    if (index == -1) return;
    articles[index] = article;
    await saveArticles(articles);
  }

  // Supprimer un article
  static Future<void> deleteArticle(int id) async {
    final articles = await loadArticles();
    articles.removeWhere((a) => a.id == id);
    await saveArticles(articles);
  }
}
