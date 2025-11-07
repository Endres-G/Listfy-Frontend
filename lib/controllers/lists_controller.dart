// lib/controllers/lists_controller.dart (atualizado)

import 'package:get/get.dart';

class ItemModel {
  final String nome;
  final String atribuidoA;
  bool comprado;

  ItemModel({
    required this.nome,
    required this.atribuidoA,
    this.comprado = false,
  });
}

class ListModel {
  final String nome;
  final String criador;
  final DateTime dataCriacao;
  final int pendentes;
  final String descricao;
  final List<ItemModel> itens;

  ListModel({
    required this.nome,
    required this.criador,
    required this.dataCriacao,
    required this.pendentes,
    required this.descricao,
    required this.itens,
  });
}

class ListController extends GetxController {
  var listas = <ListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    carregarListas();
  }

  void carregarListas() {
    listas.value = [
      ListModel(
        nome: "Compras da Semana",
        criador: "Eduarda",
        dataCriacao: DateTime(2025, 10, 1),
        pendentes: 3,
        descricao: "Lista de compras de supermercado da semana.",
        itens: [
          ItemModel(nome: "Leite", atribuidoA: "Eduarda"),
          ItemModel(nome: "Pão", atribuidoA: "João"),
          ItemModel(nome: "Ovos", atribuidoA: "Maria", comprado: true),
        ],
      ),
      ListModel(
        nome: "Tarefas do Grupo A",
        criador: "Grupo A",
        dataCriacao: DateTime(2025, 9, 28),
        pendentes: 1,
        descricao: "Tarefas semanais do grupo.",
        itens: [
          ItemModel(nome: "Relatório", atribuidoA: "Lucas"),
          ItemModel(nome: "Apresentação", atribuidoA: "Ana", comprado: true),
        ],
      ),
    ];
  }

  void criarNovaLista() {
    print("Criar nova lista...");
  }
}
