import 'package:flutter/material.dart';

final List imgList = [

  ['https://images.pexels.com/photos/1391487/pexels-photo-1391487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1','Tomate'],
  ['https://images.pexels.com/photos/7333133/pexels-photo-7333133.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1','Manzanas'],
  ['https://images.pexels.com/photos/12572532/pexels-photo-12572532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',"Berenjena"],
  ['https://images.pexels.com/photos/4051565/pexels-photo-4051565.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',"Chocolates"],
  ['https://images.pexels.com/photos/8963446/pexels-photo-8963446.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',"Pan Artesanal"]
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item[0], fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    ' ${item[1]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ))
    .toList();