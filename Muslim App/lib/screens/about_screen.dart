import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Tentang Aplikasi', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mosque, size: 100, color: AppColors.primary),
              SizedBox(height: 20),
              Text(
                'Muslim App',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              SizedBox(height: 10),
              Text(
                'Versi 1.0.0',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0,4))
                  ]
                ),
                child: Text(
                  'Aplikasi ini dibuat untuk membantu umat Muslim dalam menjalankan ibadah sehari-hari. Fitur utama termasuk jadwal shalat, Al-Quran digital, kumpulan doa harian, dan petunjuk arah kiblat.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textDark, height: 1.5),
                ),
              ),
              SizedBox(height: 40),
              Text(
                '© 2026 Developer',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
