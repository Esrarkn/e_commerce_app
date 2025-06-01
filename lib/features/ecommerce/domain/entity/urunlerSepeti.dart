class UrunlerSepeti {
  int sepetId;
  String ad;
  String resim;
  String kategori;
  int fiyat;
  String marka;
  int siparisAdeti;
  String kullaniciAdi;
  UrunlerSepeti({
    required this.sepetId,
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
    required this.siparisAdeti,
    required this.kullaniciAdi,
  });
  factory UrunlerSepeti.fromJson(Map<String, dynamic> json) {
    return UrunlerSepeti(
      sepetId: json["sepetId"],
      ad: json["ad"],
      resim: json["resim"],
      kategori: json["kategori"],
      fiyat: json["fiyat"],
      marka: json["marka"],
      siparisAdeti: json["siparisAdeti"],
      kullaniciAdi: json["kullaniciAdi"],

    );
  }
}
