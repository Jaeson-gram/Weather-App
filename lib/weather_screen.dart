import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/addtional_information_items.dart';
import 'package:http/http.dart' as http;

import 'hourly_forcast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  // double temperature = 0;

  // @override
  // void initState() {
  //   super.initState();

  //   try {
  //     getCurrentWeather();
  //   } catch (error) {
  //     throw error.toString();
  //   }
  // }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      String apiKey = 'b42e3dcc4fda4ccd124029a59eaf523c';

      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey'));

      final data = jsonDecode(response.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }

      return data;
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  void initState() {
    super.initState();

    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // GestureDetector(
          //   onTap: () => {
          //     print("refresh button pushed")
          //   },
          //   child: const Icon(Icons.refresh),
          // )

          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            //handle loading and errors with the FutureBuilder <3
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;
            final currentTemp = data['list'][0]['main']['temp'];
            final currentCondition = data['list'][0]['weather'][0]['main'];
            final currentPressure = data['list'][0]['main']['pressure'];
            final currentHumidity = data['list'][0]['main']['humidity'];
            final currentWind = data['list'][0]['wind']['speed'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  //main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentCondition == 'Clouds' ||
                                          currentCondition == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  currentCondition,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 5; i++)
                  //         HourlyForcastItem(
                  //           timeOfDay: data['list'][i]['dt'].toString(),
                  //           icon: data['list'][i]['weather'][0]['main'] ==
                  //                       'Clouds' ||
                  //                   data['list'][i]['weather'][0]['main'] ==
                  //                       'Rain'
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //           value: data['list'][i]['main']['temp'].toString(),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  //coming days weather forcast cards

                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlySky =
                            data['list'][index + 1]['weather'][0]['main'];
                        final time = DateTime.parse(hourlyForecast['dt_txt']);

                        return HourlyForcastItem(
                          timeOfDay: DateFormat.j().format(time),
                          value: hourlyForecast['main']['temp'].toString(),
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //additional information
                  const Text(
                    'Addtional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInformationItems(
                        icon: Icons.water_drop_outlined,
                        label: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInformationItems(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: currentWind.toString(),
                      ),
                      AdditionalInformationItems(
                        icon: Icons.beach_access_rounded,
                        label: 'Pressure',
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 70,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black87,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          weather = getCurrentWeather();
                        });
                      },
                      child: const Text(
                        'Refresh Weather Condition',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
