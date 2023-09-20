import 'package:flutter/material.dart';
import 'package:pmsn20232/screens/princ/counter.dart';
import 'package:pmsn20232/screens/princ/image_carousel.dart';

class FrutasScreen extends StatefulWidget {
  const FrutasScreen({super.key});

  @override
  State<FrutasScreen> createState() => _FrutasScreenState();
}

class _FrutasScreenState extends State<FrutasScreen> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 60, 205, 31),
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: ()=> Navigator.pop(context, '/frutas'),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 60, 205, 31),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CarouselWithIndicatorDemo(),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                      )),
                  height: 600,
                  width: 500,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Mango',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('1 each'),
                          SizedBox(
                            height: 20.0,
                          ),
                          CounterDesign(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Product Description',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'A mango is a type of fruit. '
                            'The mango tree is native to South Asia, '
                            'from where it has been taken to become one of the most widely cultivated fruits in the tropics.'
                            'It is harvested in the month of march (summer season) till the end of May.',
                            style:
                                TextStyle(letterSpacing: 2.0, fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.amber[200]!),
                                ),
                                height: 70.0,
                                child: ElevatedButton (
                                  //color: Colors.white,
                                  //elevation: 0.0,
                                  child: IconButton(
                                      onPressed: _toggleFavorite,
                                      icon: _isFavorited
                                          ? Icon(
                                              Icons.favorite_border,
                                              color: Colors.amber[300],
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.amber[300],
                                            )),
                                  onPressed: _toggleFavorite,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                height: 70.0,
                                minWidth: 260.0,
                                child: ElevatedButton(
                                  //elevation: 0.0,
                                  //color: Colors.amber[300],
                                  onPressed: () {},
                                  child: Text(
                                    'Add to cart',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}