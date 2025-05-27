import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/relatorios/relatorios_bloc.dart';
import '../../../bloc/relatorios/relatorios_state.dart';
import '../../../bloc/relatorios/relatorios_event.dart';
import 'relatorio_detail_page.dart';
import 'relatorio_form_page.dart';
import './relatorio_editar_page.dart';

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
      appBar: AppBar(title: const Text('Relatórios')),
      body: BlocBuilder<RelatorioBloc, RelatorioState>(
        builder: (context, state) {
          if (state is RelatorioCarregando) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RelatorioCarregado) {
            if (state.relatorios.isEmpty) {
              return const Center(child: Text('Nenhum relatório cadastrado.'));
            }

            return ListView.builder(
              itemCount: state.relatorios.length,
              itemBuilder: (_, i) {
                final r = state.relatorios[i];
                return ListTile(
                  title: Text(
                    'Relatório ${r.relatorioN}',
                  ), // Número do relatório
                  subtitle: Text(
                    '${r.data.day}/${r.data.month}/${r.data.year}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ), // Ícone de lápis
                        tooltip: 'Editar Relatório',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider.value(
                                    value: context.read<RelatorioBloc>(),
                                    child: EditarRelatorioPage(relatorio: r),
                                  ),
                            ),
                          );
                        },
                      ),
                      const Icon(
                        Icons.chevron_right,
                      ), // Ícone de seta para detalhes
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RelatorioDetailPage(relatorio: r),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
      ),
    );
  }
}
