import 'package:app_movil/main.dart';
import 'package:flutter/material.dart';

class AppBarMenu extends StatefulWidget implements PreferredSizeWidget {
  final title;
  const AppBarMenu({super.key, required this.title});

  @override
  State<AppBarMenu> createState() => _AppBarMenuState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _AppBarMenuState extends State<AppBarMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title,
      style: const TextStyle(
        fontSize: 22,
        color:Colors.white,
        fontFamily: 'Caprismo',
      ),
      ),centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          final myapp= MyApp.of(context);
          if (myapp != null){
            myapp.changeTheme();
          }
        }, icon: Theme.of(context).brightness == Brightness.light
        ? const Icon(Icons.dark_mode)
        : const Icon(Icons.light_mode),
        ),
      ],
      backgroundColor:const  Color.fromARGB(255, 86, 133, 87),
    );
  }
}