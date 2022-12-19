import 'package:flutter/material.dart';

class PokedexService extends ChangeNotifier {
    static Color getTypeColor(String type) {
    return type == "Grass" ? Colors.greenAccent : type == "Fire" ? Colors.redAccent 
    : type == "Water" ? Colors.blue : type == "Poison" ? Colors.deepPurpleAccent 
    : type == "Electric" ? Colors.amber : type == "Rock" ? Colors.grey 
    : type == "Ground" ? Colors.brown : type == "Psychic" ? Colors.indigo 
    : type == "Fighting" ? Colors.orange : type == "Bug" ? Colors.lightGreenAccent 
    : type == "Ghost" ? Colors.deepPurple : type == "Normal" ? Colors.black26 : Colors.pink;
  }
}
