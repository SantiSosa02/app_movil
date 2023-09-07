import 'dart:io';
import 'package:app_movil/presentation/screens/food_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/datos/foods_list.dart';
import 'package:app_movil/dominio/models/food.dart';
import 'package:image_picker/image_picker.dart';

class FoodRegistrationHome extends StatefulWidget {
  const FoodRegistrationHome({super.key});

  @override
  State<FoodRegistrationHome> createState() => _FoodRegistrationHomeState();
}

class _FoodRegistrationHomeState extends State<FoodRegistrationHome> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String image = "";

  Future<void> _pickImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      setState(() {
        image = pickImage.path;
      });
    }
  }

  void validation() {

    
    final nameValidate = _nameController.text;

    if (image.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "La imagen es requerida. Por favor selecciona una."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });
    } else if (foods.any((food) => food.name == nameValidate)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("El alimento ya se encuentra registrado"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });
    } else {
      var descriptionController = _descriptionController.text;
      var quantityController = _quantityController.text;
      var newFood = Food(
          name: nameValidate,
          description: descriptionController,
          quantity: int.parse(quantityController),
          expDate: date,
          image: image);
      foods.add(newFood);
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FoodHome(),
              ),
            );
          });

          return const AlertDialog(
            title: Text("Éxito", style: TextStyle(color: Colors.green)),
            content: Text("¡Alimento registrado!"),
          );
        },
      );
    }
  }

  DateTime date = DateTime(2023, 09, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: "NutriSabor"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Registrar",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 38,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 34,
              ),
              if (image.isEmpty)
                GestureDetector(
                  onTap: _pickImage,
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundColor: Color.fromARGB(179, 128, 126, 126),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(height: 4),
                        Text('Escoge una foto',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              if (image.isNotEmpty)
                CircleAvatar(
                  radius: 80,
                  child: ClipOval(
                    child: Image.file(
                      File(image),
                      fit: BoxFit.cover,
                      width: 2 * 80,
                      height: 2 * 80,
                    ),
                  ),
                ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nombre"),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingresar un nombre";
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descripción"),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingresar una descripción";
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Cantidad"),
                keyboardType: TextInputType.number,
                controller: _quantityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingresar una cantidad";
                  }
                },
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                child: Text('Fecha de vencimiento', style: TextStyle(color: Colors.black),),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context, 
                    initialDate: date, 
                    firstDate: DateTime(1900), 
                    lastDate: DateTime(2100),
                    );

                    if (newDate == null) return;

                    setState(() => date = newDate);
                    
                },
                ),

              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: "Fecha de vencimiento"),
              //   keyboardType: TextInputType.datetime,
              //   controller: _expDateController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Por favor ingresar una fecha";
              //     }
              //   },
              // ),

              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      validation();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 252, 90, 20),
                  ),
                  child: const Text(
                    'Registrar Alimento',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
