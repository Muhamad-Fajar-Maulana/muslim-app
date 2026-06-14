import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/jadwal.dart';
import '../utils/app_colors.dart';

class JadwalScreen extends StatefulWidget {
  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  late Future<List<JadwalModel>> futureJadwal;

  @override
  void initState() {
    super.initState();
    futureJadwal = ApiService.getJadwalShalat();
  }

  Widget _buildTimeCard(String label, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          Text(time, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Jadwal Shalat', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<JadwalModel>>(
        future: futureJadwal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Gagal memuat jadwal'));
          }

          final todayString = "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
          JadwalModel? todayJadwal;
          try {
             todayJadwal = snapshot.data!.firstWhere((element) => element.date == todayString);
          } catch(e) {
             todayJadwal = snapshot.data!.first; 
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lokasi: Kab. Cianjur',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                SizedBox(height: 5),
                Text(
                  todayJadwal.tanggal,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                _buildTimeCard('Imsak', todayJadwal.imsak),
                _buildTimeCard('Subuh', todayJadwal.subuh),
                _buildTimeCard('Terbit', todayJadwal.terbit),
                _buildTimeCard('Dhuha', todayJadwal.dhuha),
                _buildTimeCard('Dzuhur', todayJadwal.dzuhur),
                _buildTimeCard('Ashar', todayJadwal.ashar),
                _buildTimeCard('Maghrib', todayJadwal.maghrib),
                _buildTimeCard('Isya', todayJadwal.isya),
              ],
            ),
          );
        },
      ),
    );
  }
}
