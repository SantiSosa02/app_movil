import 'package:app_movil/datos/producto.list.dart';
import 'package:app_movil/dominio/models/producto.dart';
import 'package:app_movil/presentation/screens/producto_registrar_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductoHomeScreen extends StatefulWidget {
  const ProductoHomeScreen({Key? key}) : super(key: key);

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

  Future<void> _navigateToProductoRegistadoScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductoRegistadoScreen(),
      ),
    );

    if (result != null && result is Product) {
      setState(() {
        // Agregar el producto a la lista de productos
        productos.add(result);
        filterItems = productos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(title: 'Productos'),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: searchItem,
              controller: _buscarController,
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
                return Card(
                  child: ListTile(
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
                                  filterItems[index].image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 20),
                                Text('Nombre : ${filterItems[index].name}'),
                                Text(
                                    'Descripción : ${filterItems[index].description}'),
                                Text(
                                    'Cantidad :${filterItems[index].quiantity}'),
                                Text(
                                  'Estado : ${filterItems[index].state ? 'Activo' : 'Inactivo'}',
                                ),
                                Text(
                                  'Fecha de vencimiento: ${DateFormat('dd-MM-yyyy').format(filterItems[index].expirationDate)}',
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
                    title: Text(filterItems[index].name),
                    subtitle: Text(
                      'Descripción: ${filterItems[index].description}\nCantidad: ${filterItems[index].quiantity}',
                    ),
                    leading: Image.network(
                      filterItems[index].image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        setState(() {
                          productos.remove(filterItems[index]);
                          filterItems = productos;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToProductoRegistadoScreen,
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
