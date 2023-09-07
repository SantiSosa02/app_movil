import 'package:app_movil/presentation/screens/login_screen.dart';
import 'package:app_movil/presentation/screens/home_screen.dart';
import 'package:app_movil/presentation/screens/usuario_screen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 167, 194, 168),
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 178, 222, 180),
              image: DecorationImage(
                image: AssetImage('assets/images/comida.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 270,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 182, 187, 49), width: 2.0),
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 182, 187, 49)),
            child: ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                "Pagina principal",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 270,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 21, 104, 57), width: 2.0),
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 21, 104, 57)),
            child: ListTile(
              leading: const Icon(
                Icons.restaurant,
                color: Colors.white,
              ),
              title: const Text(
                "Usuarios",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsuarioHome(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 270,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 35, 123, 126), width: 2.0),
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 35, 123, 126)),
            child: ListTile(
              leading:
                  const Icon(Icons.date_range_rounded, color: Colors.white),
              title: const Text(
                "Alimentos",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 270,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 30, 81, 123), width: 2.0),
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 30, 81, 123)),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              title: const Text(
                "Cercanos a vencer",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Cerrar Sesión"),
                          content:
                              Text("¿Está seguro de que desea cerrar sesión?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Cerrar Sesión",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.exit_to_app),
                ),
                Text("Cerrar Sesión"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
