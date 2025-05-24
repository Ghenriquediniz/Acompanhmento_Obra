import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/obra_model.dart';
import '../adm/relatorios/relatorio_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_event.dart';

class ObraDetailPage extends StatelessWidget {
  final Obra obra;

  const ObraDetailPage({super.key, required this.obra});

  @override
  Widget build(BuildContext context) {
    // Criar uma galeria simulada de 4 imagens (repetindo o mesmo caminho)
    final galeriaExemplo = List.generate(4, (_) => obra.imagemPath);

    return Scaffold(
      appBar: AppBar(title: Text(obra.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem principal
            obra.imagemPath != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(obra.imagemPath!),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
                : const Center(
                  child: Icon(Icons.image_not_supported, size: 100),
                ),
            const SizedBox(height: 20),
            // Informações
            Text(
              obra.nome,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Cidade: ${obra.cidade}'),
                const SizedBox(width: 20), // espaço entre os textos
                Text('Bairro: ${obra.bairro}'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${obra.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fotos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 1),
            // Galeria
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: galeriaExemplo.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final path = galeriaExemplo[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child:
                        path != null
                            ? Image.file(
                              File(path),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                            : const Icon(Icons.image_not_supported, size: 80),
                  );
                },
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.dashboard, color: Colors.grey),
                  SizedBox(height: 4),
                  Text('Visão geral', style: TextStyle(fontSize: 12)),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create:
                                (_) =>
                                    RelatorioBloc()
                                      ..add(CarregarRelatorios(obra.id)),
                            child: RelatorioListPage(obraId: obra.id),
                          ),
                    ),
                  );
                },
                child: Column(
                  children: const [Icon(Icons.assignment), Text('Relatórios')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
