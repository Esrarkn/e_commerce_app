import 'package:e_commerce_app/data/entity/urunlerSepeti.dart';

class UrunlerSepetiResponse {
  List<UrunlerSepeti> urunSepet;
  int success;

  UrunlerSepetiResponse({required this.urunSepet, required this.success});

  factory UrunlerSepetiResponse.fromJson(Map<String, dynamic> json) {
    return UrunlerSepetiResponse(
      urunSepet: json.containsKey('urunler_sepeti')
        ? (json['urunler_sepeti'] as List)
            .map((e) => UrunlerSepeti.fromJson(e))
            .toList()
        : [],
      success: json['success'],
    );
  }
}
