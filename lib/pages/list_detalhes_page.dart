import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ItemModelDetalhes {
  final String nome;
  final String status; // "pendentes", "atribuido", "comprado"

  ItemModelDetalhes({required this.nome, required this.status});
}

class ListDetalhesPage extends StatefulWidget {
  final String titulo;
  final String descricao;
  final List<ItemModelDetalhes> itens;

  const ListDetalhesPage({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.itens,
  });

  @override
  State<ListDetalhesPage> createState() => _ListDetalhesPageState();
}

class _ListDetalhesPageState extends State<ListDetalhesPage> {
  String filtro = "todos"; // pendentes, atribuidos, comprados, todos

  @override
  Widget build(BuildContext context) {
    List<ItemModelDetalhes> itensFiltrados = widget.itens.where((item) {
      if (filtro == "todos") return true;
      return item.status == filtro;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share("${widget.titulo}\n${widget.descricao}");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.descricao),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text("Filtrar: "),
                DropdownButton<String>(
                  value: filtro,
                  items: const [
                    DropdownMenuItem(value: "todos", child: Text("Todos")),
                    DropdownMenuItem(
                      value: "pendentes",
                      child: Text("Pendentes"),
                    ),
                    DropdownMenuItem(
                      value: "atribuido",
                      child: Text("Atribuídos"),
                    ),
                    DropdownMenuItem(
                      value: "comprado",
                      child: Text("Comprados"),
                    ),
                  ],
                  onChanged: (valor) {
                    setState(() {
                      filtro = valor!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itensFiltrados.length,
              itemBuilder: (context, index) {
                final item = itensFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(item.nome),
                    subtitle: Text("Status: ${item.status}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
