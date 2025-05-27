import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_event.dart';
import '../../../models/relatorio_model.dart';

class EditarRelatorioPage extends StatefulWidget {
  final Relatorio relatorio;

  const EditarRelatorioPage({super.key, required this.relatorio});

  @override
  State<EditarRelatorioPage> createState() => _EditarRelatorioPageState();
}

class _EditarRelatorioPageState extends State<EditarRelatorioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _comentarioController;
  late TextEditingController _numeroRelatorioController;
  String? _tipoSelecionado;
  DateTime? _dataSelecionada;

  final _tipos = ['Servente', 'Pedreiro', 'Eletricista', 'Outros'];

  @override
  void initState() {
    super.initState();
    _comentarioController = TextEditingController(
      text: widget.relatorio.comentario,
    );
    _numeroRelatorioController = TextEditingController(
      text: widget.relatorio.relatorioN,
    );
    _tipoSelecionado = widget.relatorio.tipoMaoDeObra;
    _dataSelecionada = widget.relatorio.data;
  }

  void _salvar() {
    if (_formKey.currentState!.validate() &&
        _dataSelecionada != null &&
        _tipoSelecionado != null) {
      final relatorioEditado = widget.relatorio.copyWith(
        data: _dataSelecionada!,
        tipoMaoDeObra: _tipoSelecionado!,
        comentario: _comentarioController.text,
        relatorioN: _numeroRelatorioController.text,
      );

      context.read<RelatorioBloc>().add(EditarRelatorio(relatorioEditado));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Relatório')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numeroRelatorioController,
                decoration: const InputDecoration(
                  labelText: 'Número do Relatório',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o número' : null,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final data = await showDatePicker(
                    context: context,
                    initialDate: _dataSelecionada ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (data != null) {
                    setState(() => _dataSelecionada = data);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Data'),
                    controller: TextEditingController(
                      text:
                          '${_dataSelecionada?.day}/${_dataSelecionada?.month}/${_dataSelecionada?.year}',
                    ),
                    validator:
                        (_) =>
                            _dataSelecionada == null
                                ? 'Selecione a data'
                                : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _tipoSelecionado,
                items:
                    _tipos
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => _tipoSelecionado = val),
                decoration: const InputDecoration(
                  labelText: 'Tipo de Mão de Obra',
                ),
                validator: (v) => v == null ? 'Selecione o tipo' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _comentarioController,
                decoration: const InputDecoration(labelText: 'Comentário'),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'Informe o comentário' : null,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
