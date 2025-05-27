//Cadastrar relatorio pagina
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_event.dart';
import '../../../models/relatorio_model.dart';

class RelatorioFormPage extends StatefulWidget {
  final String obraId;
  const RelatorioFormPage({super.key, required this.obraId});

  @override
  State<RelatorioFormPage> createState() => _RelatorioFormPageState();
}

class _RelatorioFormPageState extends State<RelatorioFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();
  final _comentarioController = TextEditingController();

  String? _tipoSelecionado;
  DateTime? _dataSelecionada;

  final List<String> _tipos = ['Servente', 'Pedreiro', 'Eletricista', 'Outros'];

  void _salvar() {
    if (_formKey.currentState!.validate() &&
        _dataSelecionada != null &&
        _tipoSelecionado != null) {
      final relatorio = Relatorio(
        id: const Uuid().v4(),
        relatorioN: _numeroController.text,
        obraId: widget.obraId,
        data: _dataSelecionada!,
        tipoMaoDeObra: _tipoSelecionado!,
        comentario: _comentarioController.text,
        fotos: [],
        videoUrl: null,
      );
      context.read<RelatorioBloc>().add(AdicionarRelatorio(relatorio));
      Navigator.pop(context);
    }
  }

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Relatório')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Número do Relatório:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(hintText: 'Ex: 00123'),
                validator: (v) => v!.isEmpty ? 'Informe o número' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                readOnly: true,
                onTap: _selecionarData,
                decoration: InputDecoration(
                  hintText: 'dd/mm/aaaa',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text:
                      _dataSelecionada == null
                          ? ''
                          : '${_dataSelecionada!.day}/${_dataSelecionada!.month}/${_dataSelecionada!.year}',
                ),
                validator:
                    (v) => _dataSelecionada == null ? 'Selecione a data' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tipo de Mão de Obra:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Selecione'),
                value: _tipoSelecionado,
                items:
                    _tipos.map((tipo) {
                      return DropdownMenuItem(value: tipo, child: Text(tipo));
                    }).toList(),
                onChanged: (val) => setState(() => _tipoSelecionado = val),
                validator: (v) => v == null ? 'Selecione um tipo' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Comentário:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _comentarioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Digite o comentário...',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o comentário' : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Salvar Relatório'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
