import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/surat.dart';
import '../utils/app_colors.dart';

class DetailSuratScreen extends StatefulWidget {
  final int nomorSurat;

  const DetailSuratScreen({Key? key, required this.nomorSurat}) : super(key: key);

  @override
  _DetailSuratScreenState createState() => _DetailSuratScreenState();
}

class _DetailSuratScreenState extends State<DetailSuratScreen> {
  late Future<DetailSuratModel?> futureDetail;

  @override
  void initState() {
    super.initState();
    futureDetail = ApiService.getDetailSurat(widget.nomorSurat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Surat', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<DetailSuratModel?>(
        future: futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Gagal memuat detail surat'));
          }

          final surat = snapshot.data!;
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      surat.namaLatin,
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      surat.arti,
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${surat.tempatTurun} • ${surat.jumlahAyat} Ayat',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: surat.ayat.length,
                  itemBuilder: (context, index) {
                    final ayat = surat.ayat[index];
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.bgLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    radius: 14,
                                    child: Text(
                                      ayat.nomorAyat.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              ayat.teksArab,
                              style: GoogleFonts.lateef(fontSize: 32, fontWeight: FontWeight.bold, height: 2.0),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: 16),
                            Text(
                              ayat.teksLatin,
                              style: GoogleFonts.poppins(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 8),
                            Text(
                              ayat.teksIndonesia,
                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textDark),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
