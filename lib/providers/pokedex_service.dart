// import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

class PokedexService extends ChangeNotifier {
  final String _pokeApi = 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  void fetchPokemonData() {
    
  }

  static Color getTypeColor(String type) {
    return type == "Grass" ? Colors.greenAccent : type == "Fire" ? Colors.redAccent 
    : type == "Water" ? Colors.blue : type == "Poison" ? Colors.deepPurpleAccent 
    : type == "Electric" ? Colors.amber : type == "Rock" ? Colors.grey 
    : type == "Ground" ? Colors.brown : type == "Psychic" ? Colors.indigo 
    : type == "Fighting" ? Colors.orange : type == "Bug" ? Colors.lightGreenAccent 
    : type == "Ghost" ? Colors.deepPurple : type == "Normal" ? Colors.black26 : Colors.pink;
  }
}
