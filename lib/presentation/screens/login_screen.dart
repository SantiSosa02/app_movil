import 'package:app_movil/datos/usuario_list.dart';
import 'package:app_movil/dominio/models/usuario.dart';
import 'package:app_movil/presentation/screens/home_screen.dart';
import 'package:app_movil/presentation/screens/usuario_registrar_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void ingresar() {
    final usuario = _userController.text;
    final password = _passwordController.text;

    List<Usuario> filterItems =
        usuarios.where((user) => user.user == usuario).toList();

    if (filterItems.isNotEmpty) {
      Usuario usuarioEncontrado = filterItems[0];

      if (usuarioEncontrado.password == password) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("El usuario no fue encontrado"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 190,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 59, 189, 63),
                  ),
                  borderRadius: BorderRadius.circular(90)),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Container(
              width: 320,
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Usario"),
                controller: _userController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese el nombre";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 320,
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Contraseña"),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Porfavor ingrese el nombre";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    ingresar();
                  },
                  style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 46, 130, 49),
                  ),
                  child: Text("Ingresar",
                  style: TextStyle(color:Colors.white),)),
            ),
            const SizedBox(height: 40,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
              const RegistrarUsuarioScreen(),
              ),
              
              );
              
            },
             child: const Text("Crear Usuario"),
            )
          ],
        ),
      ),
    ));
  }
}
