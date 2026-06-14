class SuratModel {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audioFull;

  SuratModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  factory SuratModel.fromJson(Map<String, dynamic> json) => SuratModel(
        nomor: json["nomor"] ?? 0,
        nama: json["nama"] ?? '',
        namaLatin: json["namaLatin"] ?? '',
        jumlahAyat: json["jumlahAyat"] ?? 0,
        tempatTurun: json["tempatTurun"] ?? '',
        arti: json["arti"] ?? '',
        deskripsi: json["deskripsi"] ?? '',
        audioFull: json["audioFull"] != null ? (json["audioFull"]["01"] ?? "") : "",
      );
}

class DetailSuratModel {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audioFull;
  final List<AyatModel> ayat;

  DetailSuratModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
  });

  factory DetailSuratModel.fromJson(Map<String, dynamic> json) => DetailSuratModel(
        nomor: json["nomor"] ?? 0,
        nama: json["nama"] ?? '',
        namaLatin: json["namaLatin"] ?? '',
        jumlahAyat: json["jumlahAyat"] ?? 0,
        tempatTurun: json["tempatTurun"] ?? '',
        arti: json["arti"] ?? '',
        deskripsi: json["deskripsi"] ?? '',
        audioFull: json["audioFull"] != null ? (json["audioFull"]["01"] ?? "") : "",
        ayat: json["ayat"] != null ? List<AyatModel>.from(json["ayat"].map((x) => AyatModel.fromJson(x))) : [],
      );
}

class AyatModel {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, dynamic>? audio;

  AyatModel({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    this.audio,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        nomorAyat: json["nomorAyat"] ?? 0,
        teksArab: json["teksArab"] ?? '',
        teksLatin: json["teksLatin"] ?? '',
        teksIndonesia: json["teksIndonesia"] ?? '',
        audio: json["audio"],
      );
}
