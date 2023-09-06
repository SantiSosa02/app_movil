import 'dart:io';

import 'package:app_movil/datos/usuario_list.dart';
import 'package:app_movil/dominio/models/usuario.dart';
import 'package:app_movil/presentation/screens/usuario_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UsuarioRegistrationHome extends StatefulWidget {
  const UsuarioRegistrationHome({super.key});

  @override
  State<UsuarioRegistrationHome> createState() => _UsuarioRegistrationHomeState();
}

class _UsuarioRegistrationHomeState extends State<UsuarioRegistrationHome> {
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
              content: Text("Las contraseñas no coinciden"),
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
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Exito"),
              content: Text("Usuario registrado"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      const UsuarioHome(),
                      ),
                      );
                    },
                    child: const Text("Cerrar"))
              ],
            );
          });

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: "Registro"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Registro Usuario",
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign:TextAlign.center,
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
                const SizedBox(height: 34,),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(9, 50)
                ),
                child: const Text('Selecciona foto'),
              ),
               const SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nombre"),
                controller: _userController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese el nombre";
                  }
                },
              ),
              const SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Contraseña"),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese la contraseña";
                  }
                },
              ),
              const SizedBox(height: 12,),
              TextFormField(
                decoration: const InputDecoration(labelText: "Confirmar contraseña"),
                controller: _confirmPassContraoller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor verifique la contraseña";
                  }
                },
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                    verfificarExitencia();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 46, 130, 49), ),
                  child: const Text('Registrar',style: TextStyle(color:Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
