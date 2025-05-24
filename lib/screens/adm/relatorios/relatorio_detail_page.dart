import 'package:flutter/material.dart';
import '../../../models/relatorio_model.dart';

class RelatorioDetailPage extends StatelessWidget {
  final Relatorio relatorio;

  const RelatorioDetailPage({super.key, required this.relatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Relatório')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${relatorio.id}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Data: ${relatorio.data.day}/${relatorio.data.month}/${relatorio.data.year}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Tipo de Mão de Obra: ${relatorio.tipoMaoDeObra}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Comentário: ${relatorio.comentario}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text('Fotos:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relatorio.fotos.length,
                itemBuilder: (context, index) {
                  final foto = relatorio.fotos[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(foto),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (relatorio.videoUrl != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vídeo:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  // Aqui você pode usar um player de vídeo, como o VideoPlayer do Flutter
                  Text('URL do vídeo: ${relatorio.videoUrl}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
