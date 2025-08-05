import 'package:flutter/material.dart';

class ManageArticles extends StatelessWidget {
  final articles = [
    {'name': 'Ordinateur', 'price': '450000'},
    {'name': 'Smartphone', 'price': '300000'},
    {'name': 'Clavier', 'price': '15000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des articles"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // ouvrir formulaire d’ajout (à venir)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Formulaire d'ajout à venir")));
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: articles.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, index) {
          final article = articles[index];
          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(article['name']!),
            subtitle: Text("${article['price']} FCFA"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Modifier: ${article['name']}")));
                    }),
                IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Supprimer: ${article['name']}")));
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
