import 'package:flutter/material.dart';


class LikesvidesWidget extends StatefulWidget {
  const LikesvidesWidget({super.key});
  @override
  _LikesvidesWidgetState createState() => _LikesvidesWidgetState();
}

class _LikesvidesWidgetState extends State<LikesvidesWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LikesvidesWidget - FRAME

    return Container(
      width: 375,
      height: 667,
      decoration: const BoxDecoration(
        color : Color.fromRGBO(26, 32, 37, 1),
      ),
      child: Stack(
          children: <Widget>[
      Positioned(
      top: -18,
          left: 0,
          child: Container(
              width: 375.774658203125,
              height: 73.98063659667969,

              child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 375.774658203125,
                            height: 73.98063659667969,
                            decoration: const BoxDecoration(
                              boxShadow : [BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  offset: Offset(0,0),
                                  blurRadius: 5
                              )],
                              color : Color.fromRGBO(26, 32, 37, 1),
                            )
                        )
                    ),
                  ]
              )
          )
      ),const Positioned(
        top: 18.66901397705078,
        left: 43.47447204589844,
        child: Text('Mes likes', textAlign: TextAlign.left, style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Google Sans',
            fontSize: 18,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1
        ),)
    ),Positioned(
        top: 22,
        left: 13,
        child: Container(
            width: 16.02903175354004,
            height: 16.024721145629883,

            child: Stack(
                children: const <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
              child: Text('Se connecter'),
                      )

                ]
            )
        )
    ),Positioned(
        top: 400.8151550292969,
        left: 11.742958068847656,
        child: Text('Vous n’avez encore pas liké de contenu.Cliquez sur le coeur pour en rajouter.', textAlign: TextAlign.center, style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Proxima Nova',
        fontSize: 15.26584529876709,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 1.7686541080159244
    ),)
    ),Positioned(
    top: 260,
    left: 141,
    child: Container(
    width: 94,
    height: 94,

    child: Stack(
    children: <Widget>[
    Positioned(
    top: 0,
    left: 0,
      child: Text('Se connecter'),
    ),
    ]
    )
    )
    ),
    ]
    )
    );
  }
}
