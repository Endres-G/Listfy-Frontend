import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lists_controller.dart';

class ListsPage extends StatelessWidget {
  final ListController controller = Get.put(ListController());

  ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.listas.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma lista encontrada',
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.listas.length,
          itemBuilder: (context, index) {
            final lista = controller.listas[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  lista.nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Criador: ${lista.criador}'),
                    Text(
                        'Data: ${lista.dataCriacao.day}/${lista.dataCriacao.month}/${lista.dataCriacao.year}'),
                    Text('Pendentes: ${lista.pendentes}'),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Aqui você pode abrir detalhes da lista
                  print('Abrir lista: ${lista.nome}');
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.criarNovaLista,
        child: const Icon(Icons.add),
      ),
    );
  }
}
