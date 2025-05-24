import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_event.dart';
import '../../../bloc/relatorios/relatorios_state.dart';
import '../../../models/relatorio_model.dart';
import './relatorio_list_page.dart';

class RelatorioFormPage extends StatefulWidget {
  final String obraId;

  const RelatorioFormPage({super.key, required this.obraId});

  @override
  State<RelatorioFormPage> createState() => _RelatorioFormPageState();
}

class _RelatorioFormPageState extends State<RelatorioFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _comentarioController = TextEditingController();
  final _tipoMaoDeObraController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  @override
  void dispose() {
    _comentarioController.dispose();
    _tipoMaoDeObraController.dispose();
    super.dispose();
  }

  void _salvarRelatorio() {
    if (_formKey.currentState!.validate()) {
      final novoRelatorio = Relatorio(
        id: const Uuid().v4(),
        obraId: widget.obraId,
        data: _dataSelecionada,
        tipoMaoDeObra: _tipoMaoDeObraController.text,
        comentario: _comentarioController.text,
        fotos: [],
        videoUrl: null,
      );

      // ✅ Adiciona o relatório no Bloc
      context.read<RelatorioBloc>().add(AdicionarRelatorio(novoRelatorio));

      // ✅ Retorna para a lista
      Navigator.pop(context);
    }
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Relatório')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tipoMaoDeObraController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Mão de Obra',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o tipo de mão de obra';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _comentarioController,
                decoration: const InputDecoration(labelText: 'Comentário'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um comentário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _selecionarData(context),
                    child: const Text('Selecionar Data'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _salvarRelatorio,
                child: const Text('Salvar Relatório'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
