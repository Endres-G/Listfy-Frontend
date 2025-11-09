// lib/controllers/lists_controller.dart

import 'package:get/get.dart';

class ItemModel {
  String nome;
  int quantidade;
  String unidade;
  String atribuidoA;
  bool comprado;

  ItemModel({
    required this.nome,
    required this.quantidade,
    required this.unidade,
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
  RxList<ItemModel> itens;

  ListModel({
    required this.nome,
    required this.criador,
    required this.dataCriacao,
    required this.pendentes,
    required this.descricao,
    required List<ItemModel> itens,
  }) : itens = RxList<ItemModel>(itens);
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
          ItemModel(
            nome: "Leite",
            quantidade: 1,
            unidade: "L",
            atribuidoA: "Eduarda",
          ),
          ItemModel(
            nome: "Pão",
            quantidade: 5,
            unidade: "un",
            atribuidoA: "João",
          ),
          ItemModel(
            nome: "Ovos",
            quantidade: 12,
            unidade: "un",
            atribuidoA: "Maria",
            comprado: true,
          ),
        ],
      ),
      ListModel(
        nome: "Tarefas do Grupo A",
        criador: "Grupo A",
        dataCriacao: DateTime(2025, 9, 28),
        pendentes: 1,
        descricao: "Tarefas semanais do grupo.",
        itens: [
          ItemModel(
            nome: "Relatório",
            quantidade: 1,
            unidade: "arquivo",
            atribuidoA: "Lucas",
          ),
          ItemModel(
            nome: "Apresentação",
            quantidade: 1,
            unidade: "slide",
            atribuidoA: "Ana",
            comprado: true,
          ),
        ],
      ),
    ];
  }

  // ADICIONAR ITEM
  void adicionarItem(int listaIndex, ItemModel item) {
    listas[listaIndex].itens.add(item);
    listas.refresh();
  }

  // EDITAR ITEM
  void editarItem(int listaIndex, int itemIndex, ItemModel novoItem) {
    listas[listaIndex].itens[itemIndex] = novoItem;
    listas.refresh();
  }

  // EXCLUIR ITEM
  void excluirItem(int listaIndex, int itemIndex) {
    listas[listaIndex].itens.removeAt(itemIndex);
    listas.refresh();
  }

  void criarNovaLista() {
    print("Criar nova lista...");
  }
}
