import 'package:flutter/material.dart';
import '../../utils/article_manager.dart';

class ArticleFormAdminScreen extends StatefulWidget {
  final Article? article;

  const ArticleFormAdminScreen({this.article});

  @override
  State<ArticleFormAdminScreen> createState() => _ArticleFormAdminScreenState();
}

class _ArticleFormAdminScreenState extends State<ArticleFormAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  late int price;

  @override
  void initState() {
    super.initState();
    name = widget.article?.name ?? '';
    description = widget.article?.description ?? '';
    price = widget.article?.price ?? 0;
  }

  void save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final article = Article(
      id: widget.article?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: name,
      description: description,
      price: price,
    );

    if (widget.article == null) {
      await ArticleManager.addArticle(article);
    } else {
      await ArticleManager.updateArticle(article);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article == null ? 'Ajouter Article' : 'Modifier Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (v) => (v == null || v.isEmpty) ? 'Champ requis' : null,
                onSaved: (v) => name = v ?? '',
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (v) => description = v ?? '',
              ),
              TextFormField(
                initialValue: price == 0 ? '' : price.toString(),
                decoration: InputDecoration(labelText: 'Prix (FCFA)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Champ requis';
                  final n = int.tryParse(v);
                  if (n == null || n < 0) return 'Prix invalide';
                  return null;
                },
                onSaved: (v) => price = int.parse(v ?? '0'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: save,
                child: Text(widget.article == null ? 'Ajouter' : 'Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
