import 'package:e_commerce_app/data/repo/urunlerDaoRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreenCubit extends Cubit<bool> {
  DetailScreenCubit() : super(false);

  final urunlerDaoRepository = UrunlerDaoRepository();

  Future<void> addCart(String ad, String resim, String kategori, int fiyat, String marka, int siparisAdeti, String kullaniciAdi) async {
    try {
      await urunlerDaoRepository.addCart(ad, resim, kategori, fiyat, marka, siparisAdeti, kullaniciAdi);
      // Buradaki emit sadece sepete ekleme için kullanılabilir ama favoriyle karışmasın diye istersen ayrı Cubit yapabilirsin.
    } catch (e) {
      print("Sepete ekleme hatası: $e");
    }
  }

  // Favori durumunu getir ve state olarak emit et
  Future<void> favoriDurumunuGetir(String urunId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriler = prefs.getStringList('favoriler') ?? [];
    emit(favoriler.contains(urunId));
  }

  // Favori durumu değiştir
  Future<void> favoriDegistir(String urunId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriler = prefs.getStringList('favoriler') ?? [];

    if (favoriler.contains(urunId)) {
      favoriler.remove(urunId);
      emit(false);
    } else {
      favoriler.add(urunId);
      emit(true);
    }

    await prefs.setStringList('favoriler', favoriler);
  }
}
