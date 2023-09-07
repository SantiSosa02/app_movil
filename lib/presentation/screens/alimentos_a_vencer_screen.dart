import 'package:app_movil/datos/foods_list.dart';
import 'package:app_movil/dominio/models/food.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

import '../widgets/app_bar.dart';

class AlimentosAVencer extends StatefulWidget {
  const AlimentosAVencer({Key? key}) : super(key: key);

  @override
  State<AlimentosAVencer> createState() => _AlimentosAVencerState();
}

class _AlimentosAVencerState extends State<AlimentosAVencer> {
  List<Food> filterItems = foods;
 // List<Map<String, dynamic>> alimentos =  [
    

  List<Food> obtenerAlimentosProximosAVencer() {
    DateTime today = DateTime.now();
    DateTime tenDaysFromNow = today.add(const Duration(days: 10));

    return foods.where((food) {
      DateTime expDate = food.expDate;
      return expDate.isBefore(tenDaysFromNow) &&
          expDate.isAfter(today);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Food> alimentosProximosAVencer = obtenerAlimentosProximosAVencer();

    return Scaffold(
      appBar: const AppBarMenu(title: "NutriSabor"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Alimentos próximos a vencer',
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
                //Food food = alimentosProximosAVencer[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      foods[index].name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cantidad: ${foods[index].quantity}'),
                        Text('Fecha de vencimiento: ${DateFormat('dd/MM/yyyy').format(foods[index].expDate)}',
                         style: const TextStyle(color: Colors.red) ,),
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