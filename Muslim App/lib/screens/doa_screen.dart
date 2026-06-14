import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/doa.dart';
import '../utils/app_colors.dart';

class DoaScreen extends StatefulWidget {
  @override
  _DoaScreenState createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  late Future<List<DoaModel>> futureDoa;

  @override
  void initState() {
    super.initState();
    futureDoa = ApiService.getListDoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Doa Harian', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<DoaModel>>(
        future: futureDoa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Gagal memuat data doa'));
          }

          final doaList = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: doaList.length,
            itemBuilder: (context, index) {
              final doa = doaList[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doa.doa,
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          doa.ayat,
                          style: GoogleFonts.lateef(fontSize: 28, fontWeight: FontWeight.bold, height: 1.5),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        doa.latin,
                        style: GoogleFonts.poppins(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        doa.artinya,
                        style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textDark),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
