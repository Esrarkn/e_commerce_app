class Urunler {
  int id;
  String ad;
  String resim;
  String kategori;
  int fiyat;
  String marka;
  Urunler({
    required this.id,
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
  });
  factory Urunler.fromJson(Map<String, dynamic> json) {
    return Urunler(
      id: json["id"] as int,
      ad: json["ad"] as String,
      resim: json["resim"] as String,
      kategori: json["kategori"] as String,
      fiyat: json["fiyat"] as int,
      marka: json["marka"] as String,
    );
  }
}
