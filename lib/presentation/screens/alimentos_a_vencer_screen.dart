import 'dart:io';

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
  final TextEditingController _searchController = TextEditingController();

  List<Food> alimentosProximosAVencer = [];
  List<Food> filterItems = [];

  @override
  void initState() {
    super.initState();
    alimentosProximosAVencer = obtenerAlimentosProximosAVencer();
    filterItems = alimentosProximosAVencer;
  }

  List<Food> obtenerAlimentosProximosAVencer() {
    DateTime today = DateTime.now();
    DateTime tenDaysFromNow = today.add(const Duration(days: 10));

    return foods.where((food) {
      DateTime expDate = food.expDate;
      return expDate.isBefore(tenDaysFromNow) && expDate.isAfter(today);
    }).toList();
  }

  void searchItem(String text) {
    setState(() {
      filterItems = alimentosProximosAVencer
          .where((i) => i.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: "NutriSabor"),
      body: Column(
        children: [
          Stack(
  children: [
    // Imagen de fondo con menor opacidad (0.6)
    Opacity(
      opacity: 0.9,
      child: Image.asset(
        'assets/images/alimentosFondo.jpg',
        fit: BoxFit.cover,
        height: 180.0,
        width: double.infinity,
      ),
    ),
    Positioned(
      bottom: 0, // Alinea el contenedor en la parte inferior
      left: 0,
      right: 0,
      child: Container(
        height: 50.0, // Altura del contenedor que contiene el texto
        color: Color.fromARGB(255, 11, 134, 44).withOpacity(0.5), // Fondo semi-transparente
        alignment: Alignment.center,
        child: const Text(
          'Alimentos próximos a vencer',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 5.0),
                blurRadius: 45.0,
                color: Color.fromARGB(255, 129, 129, 129),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
          ),

      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchItem,
              controller: _searchController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Buscar alimentos',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 232, 232, 232)),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 199, 199, 199)),
                  
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('${filterItems[index].name}'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(
                      File(filterItems[index].image),
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text('Nombre: ${filterItems[index].name}'),
                    Text('Descripción: ${filterItems[index].description}'),
                    Text('Cantidad: ${filterItems[index].quantity}'),
                    Text(
                      'Fecha de vencimiento: ${DateFormat('yyyy/MM/dd').format(filterItems[index].expDate)}',
                      style: TextStyle(
                      color:Colors.red),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color.fromARGB(172, 157, 157, 157),
              width: 0.7,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.file(
                  File(filterItems[index].image),
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${filterItems[index].name}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Fecha de vencimiento: ${DateFormat('yyyy/MM/dd').format(filterItems[index].expDate)}',
                      style: TextStyle(
                      color:Colors.red),
                    ),
                  ],
                ),
              ],
            ),
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


