// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/providers/providers.dart';
import 'package:pokedex/screens/details_screen.dart';
import 'package:pokedex/widgets/widgets.dart';

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
            const Positioned(
              top: -60,
              right: -60,
              child: PokeballImage(
                width: 175,
              ),
            ),
            Positioned(
              top: 60,
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
            _PokemonList(
              width: width, 
              pokedex: pokedex
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

class _PokemonList extends StatelessWidget {
  const _PokemonList({
    Key? key,
    required this.width,
    required this.pokedex,
  }) : super(key: key);

  final double width;
  final List? pokedex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 135,
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
                    child: _PokemonCard(
                      index: index,
                      pokedex: pokedex,
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
    );
  }
}

class _PokemonCard extends StatelessWidget {
  const _PokemonCard({
    Key? key,
    required this.pokedex, 
    required this.index,
  }) : super(key: key);

  final List? pokedex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: PokedexService.getTypeColor(pokedex![index]['type'][0]),
            borderRadius: const BorderRadius.all(Radius.circular(25))
          ),
          child: Stack(
            children: [
              const Positioned(
                top: -10,
                right: -10,
                child: PokeballImage(
                  height: 100,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Hero(
                  tag: index,
                  child: CachedNetworkImage(
                    alignment: Alignment.centerRight,
                    imageUrl: pokedex![index]['img'],
                    height: 110,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const PokeballImage(height: 100),
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(
          heroTag: index, 
          pokemonDetail: pokedex![index], 
          color: PokedexService.getTypeColor(pokedex![index]['type'][0]),
        )));
      },
    );
  }
}
