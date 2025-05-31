import 'package:shared_preferences/shared_preferences.dart';

// Favorilere ürün ID'si ekleme
Future<void> favoriyeEkle(String urunId) async {
  final prefs = await SharedPreferences.getInstance();
  final favoriler = prefs.getStringList('favoriler') ?? [];

  if (!favoriler.contains(urunId)) {
    favoriler.add(urunId);
    await prefs.setStringList('favoriler', favoriler);
  }
}

// Favorilerden ürün ID'si çıkarma
Future<void> favoridenCikar(String urunId) async {
  final prefs = await SharedPreferences.getInstance();
  final favoriler = prefs.getStringList('favoriler') ?? [];

  if (favoriler.contains(urunId)) {
    favoriler.remove(urunId);
    await prefs.setStringList('favoriler', favoriler);
  }
}

// Favoride mi kontrol etme
Future<bool> favorideMi(String urunId) async {
  final prefs = await SharedPreferences.getInstance();
  final favoriler = prefs.getStringList('favoriler') ?? [];
  return favoriler.contains(urunId);
}

// Favori ürün ID listesini alma
Future<List<String>> favoriUrunleriGetir() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('favoriler') ?? [];
}
