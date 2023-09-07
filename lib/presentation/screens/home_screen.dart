import 'package:app_movil/dominio/models/imagenes.dart';
import 'package:app_movil/dominio/models/usuario.dart';
import 'package:app_movil/presentation/screens/food_screen.dart';
import 'package:app_movil/presentation/screens/usuario_screen.dart';
import 'package:app_movil/presentation/widgets/app_bar.dart';
import 'package:app_movil/presentation/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'alimentos_a_vencer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMenu(title: "NutriSabor"),
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 229, 237),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UsuarioHome(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.supervisor_account,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text('Usuarios')
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 229, 237),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodHome(),
                        ),
                        );
                      },
                      icon: const Icon(
                        Icons.food_bank_rounded,
                        size: 50,
                        color: Color.fromARGB(255, 40, 34, 35),
                      ),
                    ),
                  ),
                  const Text('Alimentos')
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 229, 237),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlimentosAVencer(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_month,
                          size: 50, color: Colors.black),
                    ),
                  ),
                  const Text('A vencer')
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 84,
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
          const SizedBox(
            height: 86,
          ),
          Container(
              width: 393,
              height: 290,
              color: const Color.fromARGB(255, 85, 80, 80),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "¡Bienvenidos! Aquí, promovemos la sostenibilidad y la igualdad a través de la comida, alineados con los Objetivos de Desarrollo Sostenible de la ONU. Cada bocado cuenta en la construcción de un futuro mejor. Únete a nosotros en la revolución de la comida sostenible.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
