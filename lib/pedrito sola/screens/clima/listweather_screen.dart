import 'package:flutter/material.dart';
import 'package:pmsn20232/database/calen/agendadb.dart';
import 'package:pmsn20232/network/clima/api_weather.dart';
import 'package:pmsn20232/screens/clima/locationDetailScreen.dart';

class listWeatherMarks extends StatefulWidget {
  const listWeatherMarks({super.key});

  @override
  State<listWeatherMarks> createState() => _listWeatherMarksState();
}

class _listWeatherMarksState extends State<listWeatherMarks> {
  late Future<List<Map<String, dynamic>>> locations;

  @override
  void initState() {
    super.initState();
    locations = _getLocations();
  }

  Future<List<Map<String, dynamic>>> _getLocations() async {
    List<Map<String, dynamic>> locationList =
        await AgendaDB().getAllLocations();

    if (locationList != null) {
      List<Map<String, dynamic>> updatedList = [];

      WeatherLogic weatherLogic = WeatherLogic();

      for (var location in locationList) {
        double temperature = await weatherLogic.getTemperature(
            location['latitud'], location['longitud']);
        Map<String, dynamic> updatedLocation = {
          ...location,
          'temperature': temperature
        };
        updatedList.add(updatedLocation);
      }

      return updatedList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Ubicaciones'),
        actions: [
          IconButton(
            onPressed: () =>{
              Navigator.pop(context),
              Navigator.pushNamed(context, '/maps2').then((value) {
                setState(() {});
                })},
            icon: const Icon(Icons.map)),
            IconButton(
            onPressed: () =>
              Navigator.pushNamed(context, '//weather').then((value) {
                setState(() {});
                }),
            icon: const Icon(Icons.location_pin))
        ]
      ),
      backgroundColor: const Color.fromARGB(255, 118, 209, 255),
      body: FutureBuilder(
        future: locations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> locationList =
                snapshot.data as List<Map<String, dynamic>>;

            return ListView.separated(
              itemCount: locationList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset('assets/ubi.png', height: 50, width: 50),
                  title: Text(
                    locationList[index]['nombre'],
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Latitud: ${locationList[index]['latitud']}\nLongitud: ${locationList[index]['longitud']}\nTemperatura: ${locationList[index]['temperature']}°C',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  ),
                  
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationDetailScreen(
                            latitude: locationList[index]['latitud'],
                            longitude: locationList[index]['longitud'],
                          ),
                        ));
                  },
                );
              },
              separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).primaryColor,
              );
            }
            );
          }
        },
      ),
    );
  }
}
