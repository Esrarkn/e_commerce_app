import 'package:e_commerce_app/data/entity/urunlerSepeti.dart';
import 'package:e_commerce_app/data/repo/urunlerDaoRepository.dart';
import 'package:e_commerce_app/ui/tools/kullanici.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreenCubit extends Cubit<List<UrunlerSepeti>>{
  CartScreenCubit():super(<UrunlerSepeti>[]);
    var urunlerDaoRepository=UrunlerDaoRepository();
    //Sepetteki ürünleri getir
Future<void> loadCartProducts() async {
  var sepetListesi = await urunlerDaoRepository.loadCartProducts(kullanici_adi);
  print("Sepet Listem: $sepetListesi");
  emit(sepetListesi); 
}
//Sepetten adet ürün sil
Future<void> delete(int sepetId,String kullaniciAdi) async {
  await urunlerDaoRepository.delete(sepetId,kullanici_adi);
}
//Sepet adet arttırma vee azaltma
void updateQuantity(int sepetId, int yeniAdet) {
  if (yeniAdet < 1) return;

  final currentList = state;
  final updatedList = currentList.map((urun) {
    if (urun.sepetId == sepetId && urun.kullaniciAdi == kullanici_adi) {
      return UrunlerSepeti(
        sepetId: urun.sepetId,
        ad: urun.ad,
        marka: urun.marka,
        fiyat: urun.fiyat,
        resim: urun.resim,
        siparisAdeti: yeniAdet,
        kategori: urun.kategori,
        kullaniciAdi: urun.kullaniciAdi,
      );
    }
    return urun;
  }).toList();

  emit(updatedList);
}
//Sepetten aynı isimdeki tüm ürünleri sil
Future<void> deleteAllByProductName(String urunAdi,String kullaniciAdi) async {
  final sepetUrunleri = await urunlerDaoRepository.loadCartProducts(kullanici_adi);
  final ayniUrunler = sepetUrunleri.where((urun) => urun.ad == urunAdi).toList();

  for (var urun in ayniUrunler) {
    await urunlerDaoRepository.delete(urun.sepetId,kullanici_adi );
  }

  await loadCartProducts();
}
//Sepette aynı ürünleri birleştirip listeleme
List<UrunlerSepeti> mergeSameProducts(List<UrunlerSepeti> urunler) {
  final Map<String, UrunlerSepeti> urunMap = {};

  for (var urun in urunler) {
    if (urunMap.containsKey(urun.ad)) {
      var existing = urunMap[urun.ad]!;
      urunMap[urun.ad] = UrunlerSepeti(
        sepetId: existing.sepetId,
        ad: existing.ad,
        marka: existing.marka,
        fiyat: existing.fiyat,
        resim: existing.resim,
        siparisAdeti: existing.siparisAdeti + urun.siparisAdeti,
        kategori: existing.kategori,
        kullaniciAdi: existing.kullaniciAdi,
      );
    } else {
      urunMap[urun.ad] = urun;
    }
  }

  return urunMap.values.toList();
}
//Sepet toplam hesaplama
double calculateTotal(List<UrunlerSepeti> urunler) {
  return urunler.fold(
    0,
    (sum, item) => sum + item.fiyat * item.siparisAdeti,
  );
}


} 