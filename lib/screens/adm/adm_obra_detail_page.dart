import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ⬅️ novo
import '../../models/obra_model.dart';
import '../adm/relatorios/relatorio_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';

class ObraDetailPage extends StatefulWidget {
  final Obra obra;

  const ObraDetailPage({super.key, required this.obra});

  @override
  State<ObraDetailPage> createState() => _ObraDetailPageState();
}

class _ObraDetailPageState extends State<ObraDetailPage> {
  final List<String> _galeria = [];

  @override
  void initState() {
    super.initState();
    if (widget.obra.imagemPath != null) {
      _galeria.add(widget.obra.imagemPath!);
    }
  }

  Future<void> _selecionarFotos() async {
    final picker = ImagePicker();
    final List<XFile>? imagens = await picker.pickMultiImage();
    if (imagens != null && imagens.isNotEmpty) {
      setState(() {
        _galeria.addAll(imagens.map((e) => e.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.obra.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem principal
            widget.obra.imagemPath != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(widget.obra.imagemPath!),
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
              widget.obra.nome,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Cidade: ${widget.obra.cidade}'),
                const SizedBox(width: 20),
                Text('Bairro: ${widget.obra.bairro}'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${widget.obra.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Fotos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _galeria.isEmpty
                ? const Text('Nenhuma foto adicionada.')
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: _galeria.length,
                  itemBuilder: (context, index) {
                    final path = _galeria[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(path), fit: BoxFit.cover),
                    );
                  },
                ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selecionarFotos,
        tooltip: 'Adicionar fotos',
        child: const Icon(Icons.photo_library),
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
                          (_) => BlocProvider.value(
                            value: context.read<RelatorioBloc>(),
                            child: RelatorioListPage(obraId: widget.obra.id),
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
