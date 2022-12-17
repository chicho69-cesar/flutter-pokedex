import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List pokedex;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Color _greenColor = Color(0xff2a9d8f);
    Color _redColor = Color(0xffe76f51);
    Color _blueColor = Color(0xff37A5C6);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Image.asset(
                'assets/images/pokeball.png',
                width: 200,
                fit: BoxFit.fitWidth,
              )
            ),
            Positioned(
              top: 100,
              left: 20,
              child: Text(
                'Pokedex',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com', '/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    http.get(url).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          var data = jsonDecode(value.body);
          pokedex = data['pokemon'];
        });
      }
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }
}
