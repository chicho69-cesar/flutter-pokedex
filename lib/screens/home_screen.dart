// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? pokedex;

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

    Color greenColor = const Color(0xff2a9d8f);
    Color redColor = const Color(0xffe76f51);
    Color blueColor = const Color(0xff37A5C6);

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
            Positioned(
              top: 150,
              bottom: 0,
              width: width,
              child: Column(
                children: [
                  pokedex != null 
                    ? Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4
                        ), 
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pokedex!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              child: SafeArea(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: pokedex![index]['type'][0] == "Grass" ? Colors.greenAccent : pokedex![index]['type'][0] == "Fire" ? Colors.redAccent 
                                      : pokedex![index]['type'][0] == "Water" ? Colors.blue : pokedex![index]['type'][0] == "Poison" ? Colors.deepPurpleAccent 
                                      : pokedex![index]['type'][0] == "Electric" ? Colors.amber : pokedex![index]['type'][0] == "Rock" ? Colors.grey 
                                      : pokedex![index]['type'][0] == "Ground" ? Colors.brown : pokedex![index]['type'][0] == "Psychic" ? Colors.indigo 
                                      : pokedex![index]['type'][0] == "Fighting" ? Colors.orange : pokedex![index]['type'][0] == "Bug" ? Colors.lightGreenAccent 
                                      : pokedex![index]['type'][0] == "Ghost" ? Colors.deepPurple : pokedex![index]['type'][0] == "Normal" ? Colors.black26 : Colors.pink,
                                    borderRadius: const BorderRadius.all(Radius.circular(25))
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: -10,
                                        right: -10,
                                        child: Image.asset(
                                          'assets/images/pokeball.png',
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Hero(
                                          tag: index,
                                          child: CachedNetworkImage(
                                            imageUrl: pokedex![index]['img'],
                                            height: 150,
                                            fit: BoxFit.fitHeight,
                                            placeholder: (context, url) => const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, error) => Image.asset(
                                            'assets/images/pokeball.png',
                                            height: 150,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          ),
                                        )
                                      ),
                                      Positioned(
                                        top: 55,
                                        left: 15,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            color: Colors.black.withOpacity(0.5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                            child: Text(
                                              pokedex![index]['type'][0],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Colors.blueGrey,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 15
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ),
                                      Positioned(
                                        top: 30,
                                        left: 15,
                                        child: Text(
                                          pokedex![index]['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                            shadows: [
                                              BoxShadow(
                                                color: Colors.blueGrey,
                                                offset: Offset(0, 0),
                                                spreadRadius: 1.0,
                                                blurRadius: 15
                                              )
                                            ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                print("$index - ${pokedex![index]}");
                                Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(
                                  heroTag: index, 
                                  pokemonDetail: pokedex![index], 
                                  color: pokedex![index]['type'][0] == "Grass" ? Colors.greenAccent : pokedex![index]['type'][0] == "Fire" ? Colors.redAccent
                                    : pokedex![index]['type'][0] == "Water" ? Colors.blue : pokedex![index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                                    : pokedex![index]['type'][0] == "Electric" ? Colors.amber : pokedex![index]['type'][0] == "Rock" ? Colors.grey
                                    : pokedex![index]['type'][0] == "Ground" ? Colors.brown : pokedex![index]['type'][0] == "Psychic" ? Colors.indigo
                                    : pokedex![index]['type'][0] == "Fighting" ? Colors.orange : pokedex![index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                                    : pokedex![index]['type'][0] == "Ghost" ? Colors.deepPurple : pokedex![index]['type'][0] == "Normal" ? Colors.white70 : Colors.pink,
                                )));
                              },
                            ),
                          );
                        }
                      ),
                    )
                    : const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                height: 150,
                width: width,
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
