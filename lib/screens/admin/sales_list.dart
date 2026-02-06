import 'package:flutter/material.dart';

class SalesList extends StatelessWidget {
  final sales = [
    {'client': 'Alice', 'article': 'Ordinateur', 'total': 450000},
    {'client': 'Bob', 'article': 'Smartphone', 'total': 300000},
    {'client': 'Carlos', 'article': 'Clavier', 'total': 15000},
  ];

  SalesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des ventes")),
      body: ListView.separated(
        itemCount: sales.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, index) {
          final sale = sales[index];
          return ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text("${sale['client']} a acheté ${sale['article']}"),
            subtitle: Text("Total : ${sale['total']} FCFA"),
          );
        },
      ),
    );
  }
}
