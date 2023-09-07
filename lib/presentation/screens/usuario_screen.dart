import 'dart:io';

import 'package:app_movil/datos/usuario_list.dart';
import 'package:app_movil/dominio/models/usuario.dart';
import 'package:app_movil/presentation/screens/usuario_home_registration.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:app_movil/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';

class UsuarioHome extends StatefulWidget {
  const UsuarioHome({super.key});

  @override
  State<UsuarioHome> createState() => _UsuarioHomeState();
}

class _UsuarioHomeState extends State<UsuarioHome> {
  final TextEditingController _searchController = TextEditingController();

  List<Usuario> filterItems = usuarios;
  void searchItem(String text) {
    setState(() {
      filterItems = usuarios
          .where((i) => i.user.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: 'Usuarios'),
      drawer: MenuDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: searchItem,
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
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
                          title: Text(
                            '${filterItems[index].user}',
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(
                                    filterItems[index].image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Nombre: ${filterItems[index].user} ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Contraseña: ${filterItems[index].password}',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Mover elementos a los extremos
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(filterItems[index].image),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nombre: ${filterItems[index].user}  ',
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              final userDelete = filterItems[index].user;
                              filterItems.removeWhere(
                                  (user) => user.user == userDelete);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Exito"),
                                      content: Text("Usuario Eliminado"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cerrar"),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UsuarioRegistrationHome()));
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
