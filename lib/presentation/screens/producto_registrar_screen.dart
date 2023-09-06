import 'package:app_movil/datos/producto.list.dart';
import 'package:app_movil/presentation/screens/home_screen.dart';
import 'package:app_movil/presentation/screens/producto_home_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/dominio/models/producto.dart';
import 'package:image_picker/image_picker.dart';

class ProductoRegistadoScreen extends StatefulWidget {
  const ProductoRegistadoScreen({super.key});

  @override
  State<ProductoRegistadoScreen> createState() =>
      _ProductoRegistadoScreenState();
}

class _ProductoRegistadoScreenState extends State<ProductoRegistadoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quiantityController = TextEditingController();
  String image = '';

  Future<void> _pickImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      setState(() {
        image = pickImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: 'Registrar Producto'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'nombre'),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese por favor el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'descripción'),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ingrese una descripción del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                controller: _quiantityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresar la cantidad del producto';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Seleccionar una imagen')),
              if (image.isNotEmpty) Image.network(image),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var newProducto = Product(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            image: image);

                        productos.add(newProducto);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductoHomeScreen(),
                            ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registro seguro')),
                        );
                      }
                    },
                    child: const Text('Registrar')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
