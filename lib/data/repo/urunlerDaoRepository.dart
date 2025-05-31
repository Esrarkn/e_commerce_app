import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/data/entity/urunler.dart';
import 'package:e_commerce_app/data/entity/urunlerResponse.dart';
import 'package:e_commerce_app/data/entity/urunlerSepeti.dart';
import 'package:e_commerce_app/data/entity/urunlerSepetiResponse.dart';
import 'package:e_commerce_app/ui/tools/kullanici.dart'; 

class UrunlerDaoRepository {
  List<Urunler> parseUrunler(String response) {
    return UrunlerResponse.fromJson(json.decode(response)).urunler;
  }

  List<UrunlerSepeti> parseSepetUrunler(String response) {
    if (response.isNotEmpty && (response.trim().startsWith("{") || response.trim().startsWith("["))) {
      try {
        final jsonMap = json.decode(response);
        return UrunlerSepetiResponse.fromJson(jsonMap).urunSepet;
      } catch (e) {
        return [];
      }
    } else {
      print("Boş veya geçersiz formatta bir response alındı:\n$response");
      return [];
    }
  }

  Future<List<Urunler>> loadProducts() async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";
    var response = await Dio().get(url);
    return parseUrunler(response.data.toString());
  }

  Future<void> addCart(String ad, String resim, String kategori, int fiyat, String marka, int siparisAdeti,String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var data = {
      "ad": ad,
      "resim": resim,
      "kategori": kategori,
      "fiyat": fiyat,
      "marka": marka,
      "siparisAdeti": siparisAdeti,
      "kullaniciAdi": kullanici_adi, 
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sepete Eklendi: ${response.data.toString()}");
  }

  Future<List<UrunlerSepeti>> loadCartProducts(String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    var data = {"kullaniciAdi":  kullaniciAdi};
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("Sepetteki Ürünleri Getir: ${response.data.toString()}");
    return parseSepetUrunler(response.data.toString());
  }

  Future<void> delete(int sepetId,String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
    var data = {
      "sepetId": sepetId,
      "kullaniciAdi":  kullaniciAdi,
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));
    print("DELETE: ${response.data.toString()}");
  }
}
