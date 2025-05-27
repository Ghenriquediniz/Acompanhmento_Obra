import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/obra_bloc.dart';
import '../../bloc/obra_event.dart';
import '../../models/obra_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditarObraPage extends StatefulWidget {
  final Obra obra;

  const EditarObraPage({super.key, required this.obra});

  @override
  State<EditarObraPage> createState() => _EditarObraPageState();
}

class _EditarObraPageState extends State<EditarObraPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _cidadeController;
  late TextEditingController _bairroController;
  late String _statusSelecionado;
  File? _imagemSelecionada;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.obra.nome);
    _cidadeController = TextEditingController(text: widget.obra.cidade);
    _bairroController = TextEditingController(text: widget.obra.bairro);
    _statusSelecionado = widget.obra.status;
    if (widget.obra.imagemPath != null) {
      _imagemSelecionada = File(widget.obra.imagemPath!);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cidadeController.dispose();
    _bairroController.dispose();
    super.dispose();
  }

  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imagemSelecionada = File(picked.path);
      });
    }
  }

  void _salvarEdicao() {
    if (_formKey.currentState!.validate()) {
      final obraEditada = widget.obra.copyWith(
        nome: _nomeController.text,
        cidade: _cidadeController.text,
        bairro: _bairroController.text,
        status: _statusSelecionado,
        imagemPath: _imagemSelecionada?.path,
      );

      context.read<ObraBloc>().add(AtualizarObra(obraEditada));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Obra')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Seletor de imagem
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
                      _imagemSelecionada != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _imagemSelecionada!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          : const Center(
                            child: Text('Toque para alterar imagem de capa'),
                          ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da obra'),
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
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
                  if (value != null) setState(() => _statusSelecionado = value);
                },
                decoration: const InputDecoration(labelText: 'Status da Obra'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvarEdicao,
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
