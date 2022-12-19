// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key, 
    required this.heroTag, 
    required this.pokemonDetail, 
    required this.color
  }) : super(key: key);

  final int heroTag;
  final dynamic pokemonDetail;
  final Color color;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.pokemonDetail['type'][0] == "Normal"
        ? Colors.grey : widget.color,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              left: 15,
              child: IconButton(
                padding: const EdgeInsets.all(10),
                highlightColor: widget.color.withOpacity(0.05),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.pokemonDetail['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "#00${ widget.pokemonDetail['num'] }",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    textAlign: TextAlign.left,
                  )
                ]
              ),
            ),
            Positioned(
              top: 110,
              left: 22,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.pokemonDetail['type'].join(", "),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.18,
              right: -30,
              child: const PokeballImage(height: 200),
            ),
            _PokemonInformation(
              width: width, 
              height: height, 
              widget: widget
            ),
            Positioned(
              top: height * 0.17,
              left: (width / 2) - 125,
              child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  height: 250,
                  width: 250,
                  imageUrl: widget.pokemonDetail['img'],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const PokeballImage(height: 200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PokemonInformation extends StatelessWidget {
  const _PokemonInformation({
    Key? key,
    required this.width,
    required this.height,
    required this.widget
  }) : super(key: key);

  final double width;
  final double height;
  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: width,
        height: height * 0.6,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Name: ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17
                        ),
                      ),
                    ),
                    Text(
                      widget.pokemonDetail['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Weight: ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17
                        ),
                      ),
                    ),
                    Text(
                      widget.pokemonDetail['weight'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Spawn Time: ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17
                        ),
                      ),
                    ),
                    Text(
                      widget.pokemonDetail['spawn_time'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Weakness: ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17
                        ),
                      ),
                    ),
                    Text(
                      widget.pokemonDetail['weakness'] != null 
                        ? widget.pokemonDetail['weakness'][0].join(", ")
                        : "Not defined",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Pre Evolution', 
                        style: TextStyle(
                          color: Colors.blueGrey, 
                          fontSize: 17
                        ),
                      ),
                    ),
                    Container(
                      child: widget.pokemonDetail['prev_evolution'] != null
                      ? SizedBox(
                          height: 20,
                          width: width * 0.55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.pokemonDetail['prev_evolution'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(
                                  widget.pokemonDetail['prev_evolution'][index]['name'], 
                                  style: const TextStyle(
                                    color: Colors.black, 
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Text(
                          "Just Hatched", 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: const Text(
                        'Next Evolution', 
                        style: TextStyle(
                          color: Colors.blueGrey, 
                          fontSize: 17
                        ),
                      ),
                    ),
                    Container(
                      child: widget.pokemonDetail['next_evolution'] != null 
                      ? SizedBox(
                          height: 20,
                          width: width * 0.55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.pokemonDetail['next_evolution'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Text(
                                  widget.pokemonDetail['next_evolution'][index]['name'], 
                                  style: const TextStyle(
                                    color: Colors.black, 
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Text(
                          "Maxed Out", 
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
