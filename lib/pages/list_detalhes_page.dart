import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lists_controller.dart';

class ListDetalhesPage extends StatefulWidget {
  final int listaIndex;

  const ListDetalhesPage({super.key, required this.listaIndex});

  @override
  State<ListDetalhesPage> createState() => _ListDetalhesPageState();
}

class _ListDetalhesPageState extends State<ListDetalhesPage> {
  final controller = Get.find<ListController>();

  final nomeCtrl = TextEditingController();
  final quantidadeCtrl = TextEditingController();
  final unidadeCtrl = TextEditingController();
  final atribuidoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lista = controller.listas[widget.listaIndex];

    return Scaffold(
      appBar: AppBar(title: Text(lista.nome)),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirDialogAdicionar(),
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(lista.descricao),
          ),
          Expanded(
            child: Obx(() {
              final itens = lista.itens;

              return ListView.builder(
                itemCount: itens.length,
                itemBuilder: (context, index) {
                  final item = itens[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        "${item.nome} (${item.quantidade} ${item.unidade})",
                      ),
                      subtitle: Text("Atribuído a: ${item.atribuidoA}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _abrirDialogEditar(index, item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.excluirItem(
                              widget.listaIndex,
                              index,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // DIÁLOGO: ADICIONAR
  void _abrirDialogAdicionar() {
    nomeCtrl.clear();
    quantidadeCtrl.clear();
    unidadeCtrl.clear();
    atribuidoCtrl.clear();

    Get.defaultDialog(
      title: "Adicionar Item",
      content: Column(
        children: [
          TextField(
            controller: nomeCtrl,
            decoration: const InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: quantidadeCtrl,
            decoration: const InputDecoration(labelText: "Quantidade"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: unidadeCtrl,
            decoration: const InputDecoration(labelText: "Unidade"),
          ),
          TextField(
            controller: atribuidoCtrl,
            decoration: const InputDecoration(labelText: "Atribuído a"),
          ),
        ],
      ),
      onConfirm: () {
        controller.adicionarItem(
          widget.listaIndex,
          ItemModel(
            nome: nomeCtrl.text,
            quantidade: int.tryParse(quantidadeCtrl.text) ?? 1,
            unidade: unidadeCtrl.text,
            atribuidoA: atribuidoCtrl.text,
          ),
        );
        Get.back();
      },
      onCancel: () {},
    );
  }

  // DIÁLOGO: EDITAR
  void _abrirDialogEditar(int index, ItemModel item) {
    nomeCtrl.text = item.nome;
    quantidadeCtrl.text = item.quantidade.toString();
    unidadeCtrl.text = item.unidade;
    atribuidoCtrl.text = item.atribuidoA;

    Get.defaultDialog(
      title: "Editar Item",
      content: Column(
        children: [
          TextField(
            controller: nomeCtrl,
            decoration: const InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: quantidadeCtrl,
            decoration: const InputDecoration(labelText: "Quantidade"),
          ),
          TextField(
            controller: unidadeCtrl,
            decoration: const InputDecoration(labelText: "Unidade"),
          ),
          TextField(
            controller: atribuidoCtrl,
            decoration: const InputDecoration(labelText: "Atribuído a"),
          ),
        ],
      ),
      onConfirm: () {
        controller.editarItem(
          widget.listaIndex,
          index,
          ItemModel(
            nome: nomeCtrl.text,
            quantidade: int.tryParse(quantidadeCtrl.text) ?? 1,
            unidade: unidadeCtrl.text,
            atribuidoA: atribuidoCtrl.text,
          ),
        );
        Get.back();
      },
      onCancel: () {},
    );
  }
}
