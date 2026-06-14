import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jadwal.dart';
import '../models/doa.dart';
import '../models/surat.dart';

class ApiService {
  // Jadwal Shalat API
  static Future<List<JadwalModel>> getJadwalShalat() async {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    // Pengguna meminta spesifik Cianjur (ID: 1206)
    final String url = 'https://api.myquran.com/v2/sholat/jadwal/1206/$year/$month';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          final List<dynamic> jadwalList = data['data']['jadwal'];
          return jadwalList.map((e) => JadwalModel.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching Jadwal: $e');
      return [];
    }
  }

  // Al-Quran API
  static Future<List<SuratModel>> getListSurat() async {
    final String url = 'https://equran.id/api/v2/surat';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['code'] == 200) {
          final List<dynamic> suratList = data['data'];
          return suratList.map((e) => SuratModel.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching Surat: $e');
      return [];
    }
  }

  static Future<DetailSuratModel?> getDetailSurat(int nomor) async {
    final String url = 'https://equran.id/api/v2/surat/$nomor';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['code'] == 200) {
          return DetailSuratModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching Detail Surat: $e');
      return null;
    }
  }

  // Doa API
  static Future<List<DoaModel>> getListDoa() async {
    final String url = 'https://doa-doa-api-ahmadramadhan.fly.dev/api';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DoaModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Doa: $e');
      return [];
    }
  }
}
