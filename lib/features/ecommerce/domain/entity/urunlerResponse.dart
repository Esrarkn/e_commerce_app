import 'package:e_commerce_app/data/ecommerce/entity/urunler.dart';

class UrunlerResponse {
  List<Urunler> urunler;
  int success;

  UrunlerResponse({required this.urunler,required this.success});

  factory UrunlerResponse.fromJson(Map<String,dynamic> json){
    var success = json["success"] as int;
    var jsonArray = json["urunler"] as List<dynamic>;

    var urunler =jsonArray.map((jsonObject) => Urunler.fromJson(jsonObject)).toList();

    return UrunlerResponse(urunler: urunler, success: success);
  }
}