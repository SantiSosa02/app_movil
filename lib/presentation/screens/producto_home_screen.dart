import 'package:app_movil/datos/producto.list.dart';
import 'package:app_movil/dominio/models/producto.dart';
import 'package:app_movil/presentation/screens/producto_registrar_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ProductoHomeScreen extends StatefulWidget {
  const ProductoHomeScreen({super.key});

  @override
  State<ProductoHomeScreen> createState() => _ProductoHomeScreenState();
}

class _ProductoHomeScreenState extends State<ProductoHomeScreen> {
  final TextEditingController _buscarController = TextEditingController();
  List<Product> filterItems = productos;
  List<Product> cart = [];

  void searchItem(String text) {
    setState(() {
      filterItems = productos
          .where((i) => i.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(title: 'Productos'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductoRegistadoScreen()),
                );
              },
              child: Text('Registrar producto')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: searchItem,
              controller: _buscarController,
              decoration: const InputDecoration(
                  labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('${filterItems[index].name}'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      (filterItems[index].image),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Nombre : ${filterItems[index].name}'),
                                    Text(
                                        'Descripción : ${filterItems[index].description}'),
                                    Text(
                                        'Cantidad :${filterItems[index].quiantity}'),
                                    Text(
                                        'Estado : ${filterItems[index].state}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cerrar'))
                                ],
                              );
                            });
                      },
                      child: Card(
                        child: Column(
                          children: [
                            //Para el emulador
                            //Image.file(File(filterItems[index].photo),),
                            //para el navegador
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                filterItems[index].image,
                                height: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Nombre : ${filterItems[index].name}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Descripción :${filterItems[index].description}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          '\$ Cantidad :${filterItems[index].quiantity}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
