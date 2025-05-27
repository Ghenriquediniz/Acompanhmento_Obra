import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/obra_bloc.dart';
import '../bloc/obra_event.dart';
import 'screens/adm/admin_home_page.dart';
import '../bloc/relatorios/relatorios_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ObraBloc()..add(CarregarObras())),
        BlocProvider(create: (_) => RelatorioBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
