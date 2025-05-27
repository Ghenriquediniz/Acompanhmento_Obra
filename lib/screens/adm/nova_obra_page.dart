import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/obra_event.dart';
import '../../bloc/obra_bloc.dart';

class NovaObraPage extends StatefulWidget {
  const NovaObraPage({super.key});

  @override
  State<NovaObraPage> createState() => _NovaObraPageState();
}

class _NovaObraPageState extends State<NovaObraPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  String _statusSelecionado = 'Em andamento';
  File? _imagemCapa;

  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.gallery);
    if (imagem != null) {
      setState(() {
        _imagemCapa = File(imagem.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Obra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _selecionarImagem,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child:
                      _imagemCapa != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _imagemCapa!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          : const Center(
                            child: Text('Toque para selecionar imagem de capa'),
                          ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da obra'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _statusSelecionado,
                items: const [
                  DropdownMenuItem(
                    value: 'Em andamento',
                    child: Text('Em andamento'),
                  ),
                  DropdownMenuItem(
                    value: 'Concluída',
                    child: Text('Concluída'),
                  ),
                  DropdownMenuItem(
                    value: 'Paralisada',
                    child: Text('Paralisada'),
                  ),
                  DropdownMenuItem(
                    value: 'Não iniciada',
                    child: Text('Não iniciada'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _statusSelecionado = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Status da obra'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ObraBloc>().add(
                      AdicionarObra(
                        nome: _nomeController.text,
                        status: _statusSelecionado,
                        bairro: _bairroController.text,
                        cidade: _cidadeController.text,
                        imagemPath: _imagemCapa?.path, // Adiciona a imagem
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar Obra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
