import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_state.dart';
import '../../../bloc/relatorios/relatorios_event.dart';
import 'relatorio_detail_page.dart';
import 'relatorio_form_page.dart';

class RelatorioListPage extends StatefulWidget {
  final String obraId;

  const RelatorioListPage({super.key, required this.obraId});

  @override
  State<RelatorioListPage> createState() => _RelatorioListPageState();
}

class _RelatorioListPageState extends State<RelatorioListPage> {
  @override
  void initState() {
    super.initState();
    context.read<RelatorioBloc>().add(CarregarRelatorios(widget.obraId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios da Obra')),
      body: BlocBuilder<RelatorioBloc, RelatorioState>(
        builder: (context, state) {
          if (state is RelatorioCarregando) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RelatorioCarregado) {
            final relatorios =
                state.relatorios
                    .where((r) => r.obraId == widget.obraId)
                    .toList();

            if (relatorios.isEmpty) {
              return const Center(child: Text('Nenhum relatório cadastrado.'));
            }

            return ListView.builder(
              itemCount: relatorios.length,
              itemBuilder: (context, index) {
                final relatorio = relatorios[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: Text('Relatório ${relatorio.id}'),
                    subtitle: Text(
                      'Data: ${relatorio.data.day}/${relatorio.data.month}/${relatorio.data.year}',
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => RelatorioDetailPage(relatorio: relatorio),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is RelatorioErro) {
            return Center(child: Text(state.mensagem));
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<RelatorioBloc>(),
                    child: RelatorioFormPage(obraId: widget.obraId),
                  ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
