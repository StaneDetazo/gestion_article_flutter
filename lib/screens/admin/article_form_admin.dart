import 'package:flutter/material.dart';
import '../../utils/article_manager.dart';

class ArticleFormAdminScreen extends StatefulWidget {
  final Article? article;

  const ArticleFormAdminScreen({super.key, this.article});

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
    final isEdit = widget.article != null;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Modifier l\'article' : 'Ajouter un article',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                label: 'Nom',
                initialValue: name,
                onSaved: (v) => name = v ?? '',
                validator: (v) => (v == null || v.isEmpty) ? 'Champ requis' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Description',
                initialValue: description,
                onSaved: (v) => description = v ?? '',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Prix (FCFA)',
                initialValue: price == 0 ? '' : price.toString(),
                keyboardType: TextInputType.number,
                onSaved: (v) => price = int.parse(v ?? '0'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Champ requis';
                  final n = int.tryParse(v);
                  if (n == null || n < 0) return 'Prix invalide';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text(
                  isEdit ? 'Enregistrer' : 'Ajouter',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
