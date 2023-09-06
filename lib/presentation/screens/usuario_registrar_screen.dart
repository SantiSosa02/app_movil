import 'dart:io';

import 'package:app_movil/datos/usuario_list.dart';
import 'package:app_movil/dominio/models/usuario.dart';
import 'package:app_movil/presentation/screens/login_screen.dart';
import 'package:app_movil/presentation/screens/home_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrarUsuarioScreen extends StatefulWidget {
  const RegistrarUsuarioScreen({super.key});

  @override
  State<RegistrarUsuarioScreen> createState() => _RegistrarUsuarioScreenState();
}

class _RegistrarUsuarioScreenState extends State<RegistrarUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassContraoller = TextEditingController();
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

  bool usuarioExistente(String nombreUsuario) {
    return usuarios.any((usuario) => usuario.user == nombreUsuario);
  }

  void verfificarExitencia() {
    final nombreUsuario = _userController.text;
    final password=_passwordController.text;
    final confirmPassword= _confirmPassContraoller.text;
    if (usuarioExistente(nombreUsuario)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("El usuario ya se encuentra registrado"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });
    } else if(password != confirmPassword){
       showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Las contraseñas no coinciden"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });
    }else if(image.isEmpty){
       showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text("Las image no se ha agregado"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });
    }else {
      var newUsuario = Usuario(
          user: nombreUsuario,
          password: _passwordController.text,
          image: image);
      usuarios.add(newUsuario);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Form(
      key: _formKey,
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(width: 50,),
              const Text(
                "Registro Usuario",
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 34,
          ),
               if (image.isEmpty)
                ClipOval(
                  child: Image.asset("assets/images/avatar.png",
                      width: 80, height: 300, fit: BoxFit.cover),
                ),
              if (image.isNotEmpty)
                ClipOval(
                  child: Image.file(
                    File(
                      image,
                    ),
                    width: 70,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              
                SizedBox(height: 23,),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(9, 50)
                ),
                child: const Text('Selecciona foto'),
              ),
              SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nombre"),
                controller: _userController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese el nombre";
                  }
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Contraseña"),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese la contraseña";
                  }
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Confirmar contraseña"),
                controller: _confirmPassContraoller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor verifique la contraseña";
                  }
                },
              ),
              SizedBox(height: 23,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                    verfificarExitencia();
                    }
                  },
                  child: const Text('Registrar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
