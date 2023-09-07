import 'dart:io';
import 'package:app_movil/presentation/screens/food_home_registration.dart';
import 'package:app_movil/presentation/screens/usuario_home_registration.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:app_movil/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/dominio/models/food.dart';
import 'package:intl/intl.dart';

// Importamos la lista de alimentos
import 'package:app_movil/datos/foods_list.dart';

class FoodHome extends StatefulWidget {
  const FoodHome({super.key});

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  final TextEditingController _searchController = TextEditingController();

  List<Food> filterItems = foods;
  void searchItem(String text) {
    setState(() {
      filterItems = foods
          .where((i) => i.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: 'NutriSabor'),
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          Stack(
            children: [
              // Fondo del Screen
              Image.asset(
                'assets/images/food_home/food.jpg',
                fit: BoxFit.cover,
                height: 180.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 180.0,
                  alignment: Alignment.center,
                  child: const Text(
                    'Alimentos',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 5.0),
                          blurRadius: 45.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Positioned(
                  child: TextField(
                    onChanged: searchItem,
                    controller: _searchController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Busca alimentos',
                      prefixIcon: const Icon(Icons.search),
                      filled: true, // Rellenar el fondo del campo de texto
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors
                                .white), // Borde blanco cuando está enfocado
                        borderRadius:
                            BorderRadius.circular(25.0), // Bordes redondeados
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

//INICIO CARD
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
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text('Nombre: ${filterItems[index].name}'),
                    Text('Descripción: ${filterItems[index].description}'),
                    Text('Cantidad: ${filterItems[index].quantity}'),
                    Text(
                      'Fecha de vencimiento: ${DateFormat('yyyy/MM/dd').format(filterItems[index].expDate)}',
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
                  TextButton(
                    onPressed: () {
                      // Aquí puedes agregar la lógica para eliminar el elemento
                      setState(() {
                        // Eliminar el elemento de la lista
                        foods.remove(filterItems[index]);
                        // Actualizar la lista de elementos filtrados
                        filterItems = foods;
                      });
                      Navigator.pop(context); // Cerrar el AlertDialog
                    },
                    child: Text('Eliminar', style: TextStyle(
                      color:Colors.red),
                      ),
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
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Image.file(
                  File(filterItems[index].image),
                  height: 70,
                  width: 70,
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
                    Text('Descripción: ${filterItems[index].description}'),
                    Text('Cantidad: ${filterItems[index].quantity}'),
                    Text(
                      'Fecha de vencimiento: ${DateFormat('yyyy/MM/dd').format(filterItems[index].expDate)}',
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

//FINAL CARD
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FoodRegistrationHome()));
        },
        backgroundColor: Color.fromARGB(255, 252, 90, 20),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
