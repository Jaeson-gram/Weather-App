import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/addtional_information_items.dart';

import 'hourly_forcast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300.21K',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rain',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItem(
                      timeOfDay: '00:00', icon: Icons.cloud, value: '301.21'),
                  HourlyForcastItem(
                      timeOfDay: '03:00', icon: Icons.cloud, value: '301.47'),
                  HourlyForcastItem(
                      timeOfDay: '06:00',
                      icon: Icons.sunny_snowing,
                      value: '311.21'),
                  HourlyForcastItem(
                      timeOfDay: '09:00', icon: Icons.cloud, value: '304.21'),
                  HourlyForcastItem(
                      timeOfDay: '12:00', icon: Icons.sunny, value: '321.17'),
                  HourlyForcastItem(
                      timeOfDay: '15:00', icon: Icons.sunny, value: '321.01'),
                ],
              ),
            ),
            //coming days weather forcast cards

            const SizedBox(
              height: 30,
            ),

            //additional information
            const Text(
              'Addtional Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInformationItems(
                  icon: Icons.water_drop_outlined,
                  label: 'Humidity',
                  value: '94.09',
                ),
                AdditionalInformationItems(
                  icon: Icons.air,
                  label: 'Pressure',
                  value: '7.1',
                ),
                AdditionalInformationItems(
                  icon: Icons.beach_access_rounded,
                  label: 'Pressure',
                  value: '1007',
                ),
              ],
            ),

            const SizedBox(height: 80),

            Container(
              padding: const EdgeInsets.all(8.0),
              height: 70,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Refresh Weather Condition',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
