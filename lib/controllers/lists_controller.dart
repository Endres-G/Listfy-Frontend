import 'package:get/get.dart';

class ListModel {
  final String nome;
  final String criador;
  final DateTime dataCriacao;
  final int pendentes;

  ListModel({
    required this.nome,
    required this.criador,
    required this.dataCriacao,
    required this.pendentes,
  });
}

class ListController extends GetxController {
  // Lista simulada — futuramente pode vir de API ou banco
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
      ),
      ListModel(
        nome: "Tarefas do Grupo A",
        criador: "Grupo A",
        dataCriacao: DateTime(2025, 9, 28),
        pendentes: 1,
      ),
    ];
  }

  void criarNovaLista() {
    // Aqui você pode abrir um dialog ou navegar para outra tela
    print("Criar nova lista...");
  }
}
