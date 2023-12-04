import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn20232/network/clima/api_weather.dart';


class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherLogic weatherLogic = WeatherLogic();
  List<Map<String, dynamic>> dailyTemperatures = [];

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  Future<void> _getWeatherData() async {
    List<Map<String, dynamic>> temperatures =
        await  weatherLogic.getWeatherData();
    if (temperatures.isNotEmpty) {
      setState(() {
        dailyTemperatures = temperatures;
      });
    } else {
      // Manejar error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Actual.'),
        actions: [
          IconButton(
            onPressed: () =>{
              Navigator.pop(context),
              Navigator.pushNamed(context, '/listweather').then((value) {
                setState(() {});
                })},
            icon: const Icon(Icons.list)),
          IconButton(
            onPressed: () =>{
              Navigator.pop(context),
              Navigator.pushNamed(context, '/maps2').then((value) {
                setState(() {});
                })},
            icon: const Icon(Icons.map)),
        ]
      ),
      backgroundColor: Colors.yellow.shade700,
      body: Center( 
        child: dailyTemperatures.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${dailyTemperatures.isNotEmpty ? dailyTemperatures[0]['cityName'] : ''}',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        fontSize: 45,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                            offset: Offset(3.0, 3.0),
                          )
                        ]),
                  ),
                  LottieBuilder.asset(
                      "animation/${dailyTemperatures[0]['iconCode']}.json"),
                  Text(
                    '${dailyTemperatures[0]['temperature']}°C',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        fontSize: 40,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(3.0, 3.0),
                          )
                        ]),
                  ),
                  Text(
                    '${dailyTemperatures[0]['weatherDescription']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Max: ${dailyTemperatures[0]['maxTemperature']}°C',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Min: ${dailyTemperatures[0]['minTemperature']}°C',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Pronóstico para los próximos 5 días:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dailyTemperatures.length - 1,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 230, 165, 80)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${dailyTemperatures[index + 1]['temperature']}°C',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${dailyTemperatures[index + 1]['date']}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                  ),
                                ),
                                LottieBuilder.asset(
                                  "animation/${dailyTemperatures[index + 1]['iconCode']}.json",
                                  width: 90,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Text('Cargando datos...'),
      ),
    );
  }
}
