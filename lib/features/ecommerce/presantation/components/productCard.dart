import 'package:e_commerce_app/data/ecommerce/entity/urunler.dart';
import 'package:flutter/material.dart';
import '../../tools/appColors.dart';
class ProductCard extends StatelessWidget {
  final Urunler urun;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemoveFromFavorites;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.urun,
    this.onAddToCart,
    this.onRemoveFromFavorites,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
           child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Text(
        urun.marka,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: "Inter"),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        urun.ad,
        style: const TextStyle(color: Colors.grey),
      ),
    ),
    
    
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(
            "\$${urun.fiyat}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: mainColor,
              fontFamily: "Inter"
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: mainColor,
              shape: BoxShape.circle,
              gradient: LinearGradient(
      colors: [mainColor, textColor1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
            ),
            
            child: IconButton(
              onPressed: onAddToCart,
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  ],
),

          ),
        ),
        if (isFavorite)
          Positioned(
            top: 15,
            right: 16,
            child: GestureDetector(
              onTap: onRemoveFromFavorites,
              child: const Icon(
                Icons.favorite,
                color: Color.fromRGBO(213, 33, 20, 0.808),
                size: 28,
              ),
            ),
          ),
      ],
    );
  }
}
