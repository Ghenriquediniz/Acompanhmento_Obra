import 'package:flutter/material.dart';
import 'nova_obra_page.dart';
import 'obra_tile_page.dart';
import '../../bloc/obra_bloc.dart';
import '../../bloc/obra_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Obras'), centerTitle: true),

      body: BlocBuilder<ObraBloc, ObraState>(
        builder: (context, state) {
          if (state is ObrasCarregadas) {
            final obras = state.obras;
            return obras.isEmpty
                ? const Center(child: Text('Nenhuma obra cadastrada ainda.'))
                : ListView.builder(
                  itemCount: obras.length,
                  itemBuilder: (context, index) {
                    return ObraTile(obra: obras[index]);
                  },
                );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

      //Botão de +
      //Nova obra
      //Editar obra
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add_business),
                      title: const Text('Cadastrar nova obra'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NovaObraPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_add),
                      title: const Text('Cadastrar cliente'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NovaObraPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            IconButton(onPressed: null, icon: Icon(Icons.home)),
            SizedBox(width: 48),
            IconButton(onPressed: null, icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
