import 'package:flutter/material.dart';
//import 'package:ods_alimentos/presentations/screens/screenSecond.dart';
import 'package:intl/intl.dart'; 


import '../../dominio/models/producto.dart';
import '../widgets/app_bar.dart';
import '../widgets/drawer.dart';

class AlimentosAVencer extends StatefulWidget {
  const AlimentosAVencer({Key? key}) : super(key: key);

  @override
  State<AlimentosAVencer> createState() => _AlimentosAVencerState();
}
List<Product> productos = [];

class _AlimentosAVencerState extends State<AlimentosAVencer> {
 List<Map<String, dynamic>> alimentos =productos.cast<Map<String, dynamic>>().toList();

  List<Map<String, dynamic>> obtenerAlimentosProximosAVencer() {
    DateTime today = DateTime.now();
    DateTime tenDaysFromNow = today.add(Duration(days: 10));

    return alimentos.where((alimento) {
      DateTime fechaVencimiento = alimento['Fecha_vencimiento'];
      return fechaVencimiento.isBefore(tenDaysFromNow) &&
          fechaVencimiento.isAfter(today);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> alimentosProximosAVencer = obtenerAlimentosProximosAVencer();

    return Scaffold(
      appBar: const AppBarMenu(title: null,),
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Alimentos Próximos a Vencer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: alimentosProximosAVencer.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> alimento = alimentosProximosAVencer[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${alimento['Nombre']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cantidad: ${alimento['Cantidad']}'),
                        Text('Fecha de vencimiento: ${DateFormat('dd/MM/yyyy').format(alimentos[index]['Fecha_vencimiento'])}',
                         style: const TextStyle(color: Colors.red) ,),
                        Text('Categoría: ${alimento['Categoria']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
