import 'package:e_commerce_app/ui/components/gradientButton.dart';
import 'package:e_commerce_app/ui/cubits/detailScreenCubit.dart';
import 'package:e_commerce_app/ui/tools/kullanici.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../tools/appColors.dart';
import '../../data/entity/urunler.dart';

class DetailScreen extends StatefulWidget {
  final Urunler urun;

  const DetailScreen({super.key, required this.urun});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isFavori = false; // Favori durumu

  final Map<String, Color> kategoriRenkleri = {
    'Teknoloji': backgroundColor,
    'Aksesuar': backgroundColor,
    'Kozmetik': backgroundColor,
  };

  @override
  void initState() {
    super.initState();
    context.read<DetailScreenCubit>().favoriDurumunuGetir(
      widget.urun.id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final urun = widget.urun;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<DetailScreenCubit, bool>(
            builder: (context, favoriMi) {
              return IconButton(
                icon: Icon(
                  favoriMi ? Icons.favorite : Icons.favorite_border,
                  color: favoriMi ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context.read<DetailScreenCubit>().favoriDegistir(
                    urun.id.toString(),
                  );
                },
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}",
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    urun.marka,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontFamily: "Inter"
                    ),
                  ),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 4.5,
                      itemBuilder:
                          (_, __) =>
                              const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "4.5",
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Inter"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            Text(urun.ad, style: TextStyle(fontSize: 14, color: textColor1,fontFamily: "Inter")),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kategoriRenkleri[urun.kategori] ?? Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.category, size: 16, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text(
                    urun.kategori,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Açıklama
            Text(
              "Bu ürün ${urun.marka} tarafından üretilmiş olup yüksek kalite ve dayanıklılık sunar. Ürünü daha yakından incelemek için detaylara göz atabilirsiniz.",
              style: TextStyle(color: mainColor, fontSize: 15, height: 1.4,fontFamily: "Inter"),
            ),
            const SizedBox(height: 30),

            // Sipariş Adedi
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sipariş Adeti",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                      fontFamily: "Inter"
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: mainColor,
                        splashRadius: 20,
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter"
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: mainColor,
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Toplam: ₺${(urun.fiyat * quantity).toStringAsFixed(2)}",
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Inter"
                ),
              ),
              SizedBox(
                width: 160,
                child: gradientButton(
                  onPressed: () {
                    context.read<DetailScreenCubit>().addCart(
                      urun.ad,
                      urun.resim,
                      urun.kategori,
                      urun.fiyat,
                      urun.marka,
                      quantity,
                      kullanici_adi,
                    );
                  },
                  text: "Sepete Ekle",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
