import 'package:e_commerce_app/data/ecommerce/entity/urunler.dart';
import 'package:e_commerce_app/data/ecommerce/repo/urunlerDaoRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<List<Urunler>> {
  List<Urunler> _tumUrunler = [];

  final UrunlerDaoRepository _urunlerDaoRepository = UrunlerDaoRepository();

  HomeScreenCubit() : super([]);
  //Tüm ürünleri getir
  Future<void> loadProducts() async {
    _tumUrunler = await _urunlerDaoRepository.loadProducts();
    emit(_tumUrunler);
  }

  // Arama ve kategoriye göre filtreleme
  void searchAndFilter(String arama, String kategori) {
    if (arama.isEmpty && kategori == "Tüm Ürünler") {
      emit(_tumUrunler);
      return;
    }

    final filtrelenmis =
        _tumUrunler.where((urun) {
          final kategoriUygunMu =
              (kategori == "Tüm Ürünler") || (urun.kategori == kategori);
          final aramaUygunMu = urun.ad.toLowerCase().contains(
            arama.toLowerCase(),
          );
          return kategoriUygunMu && aramaUygunMu;
        }).toList();

    emit(filtrelenmis);
  }

  List<Urunler> get tumUrunler => _tumUrunler;
}
