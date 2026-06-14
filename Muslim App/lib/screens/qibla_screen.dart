import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../utils/app_colors.dart';

class QiblaScreen extends StatefulWidget {
  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  // Arah kiblat untuk Indonesia sekitar 292 derajat
  final double qiblaDirection = 292.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Arah Kiblat', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error membaca kompas'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          double? direction = snapshot.data?.heading;

          if (direction == null) {
            return Center(child: Text('Perangkat tidak memiliki sensor kompas.'));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Arah Ka\'bah',
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                SizedBox(height: 10),
                Text(
                  'Putar perangkat Anda untuk menyesuaikan arah',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Lingkaran kompas utara
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 8),
                      ),
                      child: Transform.rotate(
                        angle: (direction * (math.pi / 180) * -1),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'U',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Panah Kiblat
                    Transform.rotate(
                      angle: ((direction - qiblaDirection) * (math.pi / 180) * -1),
                      child: Icon(
                        Icons.navigation,
                        size: 150,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'Heading Anda: ${direction.toStringAsFixed(0)}°',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
