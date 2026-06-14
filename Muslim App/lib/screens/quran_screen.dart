import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/surat.dart';
import '../utils/app_colors.dart';
import 'detail_surat_screen.dart';

class QuranScreen extends StatefulWidget {
  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<List<SuratModel>> futureSurat;

  @override
  void initState() {
    super.initState();
    futureSurat = ApiService.getListSurat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Al-Quran', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<SuratModel>>(
        future: futureSurat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Gagal memuat surah. Periksa koneksi Anda.'));
          }

          final suratList = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: suratList.length,
            itemBuilder: (context, index) {
              final surat = suratList[index];
              return Card(
                elevation: 1,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.star_border_outlined, size: 45, color: AppColors.primary),
                      Text(
                        surat.nomor.toString(),
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  title: Text(
                    surat.namaLatin,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${surat.tempatTurun} • ${surat.jumlahAyat} Ayat',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    surat.nama,
                    style: GoogleFonts.lateef(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailSuratScreen(nomorSurat: surat.nomor)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
