import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/obra_bloc.dart';
import '../../bloc/obra_event.dart';
import '../../models/obra_model.dart';

class EditarObraPage extends StatefulWidget {
  final Obra obra;

  const EditarObraPage({super.key, required this.obra});

  @override
  State<EditarObraPage> createState() => _EditarObraPageState();
}

class _EditarObraPageState extends State<EditarObraPage> {
  late TextEditingController _nomeController;
  late TextEditingController _cidadeController;
  late TextEditingController _bairroController;
  late String _statusSelecionado;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.obra.nome);
    _cidadeController = TextEditingController(text: widget.obra.cidade);
    _bairroController = TextEditingController(text: widget.obra.bairro);
    _statusSelecionado = widget.obra.status;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cidadeController.dispose();
    _bairroController.dispose();
    super.dispose();
  }

  void _salvarEdicao() {
    final obraEditada = widget.obra.copyWith(
      nome: _nomeController.text,
      cidade: _cidadeController.text,
      bairro: _bairroController.text,
      status: _statusSelecionado,
    );

    context.read<ObraBloc>().add(AtualizarObra(obraEditada));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Obra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Obra'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _statusSelecionado,
              items: const [
                DropdownMenuItem(
                  value: 'Em andamento',
                  child: Text('Em andamento'),
                ),
                DropdownMenuItem(value: 'Concluída', child: Text('Concluída')),
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
    );
  }
}
