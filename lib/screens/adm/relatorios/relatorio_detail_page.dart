import 'package:flutter/material.dart';
import '../../../models/relatorio_model.dart';

class RelatorioDetailPage extends StatelessWidget {
  final Relatorio relatorio;
  const RelatorioDetailPage({super.key, required this.relatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data: ${relatorio.data.day}/${relatorio.data.month}/${relatorio.data.year}',
            ),
            Text('Nº Relatório ${relatorio.relatorioN}'),
            Text('Tipo: ${relatorio.tipoMaoDeObra}'),
            Text('Comentário: ${relatorio.comentario}'),

            const SizedBox(height: 12),
            const Text('Fotos (simulado):'),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: relatorio.fotos.map((f) => Image.network(f)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
