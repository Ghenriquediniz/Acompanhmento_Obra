import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/obra_model.dart';
import 'editar_obra_page.dart';
import '../shared/obra_detail_page.dart';

class ObraTile extends StatelessWidget {
  final Obra obra;

  const ObraTile({super.key, required this.obra});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading:
            obra.imagemPath != null
                ? Image.file(
                  File(obra.imagemPath!),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                : const Icon(Icons.image, size: 40),

        title: Text(obra.nome),
        subtitle: Text('${obra.cidade} - ${obra.bairro}'),

        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditarObraPage(obra: obra)),
            );
          },
        ),

        // opcional: clique no tile abre detalhes
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ObraDetailPage(obra: obra)),
          );
        },
      ),
    );
  }
}
