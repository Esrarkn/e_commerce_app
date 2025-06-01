import 'package:e_commerce_app/data/ecommerce/entity/urunlerSepeti.dart';
import 'package:e_commerce_app/ui/ecommerce/components/gradientButton.dart';
import 'package:e_commerce_app/ui/ecommerce/cubits/cartScreenCubit.dart';
import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  final String kullaniciAdi;

  const CartScreen({super.key, required this.kullaniciAdi});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  void initState() {
    super.initState();
    context.read<CartScreenCubit>().loadCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartScreenCubit, List<UrunlerSepeti>>(
        builder: (context, urunlerSepeti) {
          if (urunlerSepeti.isEmpty) {
            return const Center(child: Text("Sepetiniz boş."));
          }

          final birlesmisUrunler = context
              .read<CartScreenCubit>()
              .mergeSameProducts(urunlerSepeti);
          double toplamTutar = context.read<CartScreenCubit>().calculateTotal(
            birlesmisUrunler,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: birlesmisUrunler.length,
                  itemBuilder: (context, index) {
                    final urunSepet = birlesmisUrunler[index];

                    return Dismissible(
                      key: Key(urunSepet.sepetId.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: mainColor,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Silme işlemi"),
                              content: const Text(
                                "Bu ürünü sepetten silmek istediğinize emin misiniz?",
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(false),
                                  child: const Text("İptal"),
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(true),
                                  child: const Text("Sil"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) async {
                        await context
                            .read<CartScreenCubit>()
                            .deleteAllByProductName(
                              urunSepet.ad,currentUserId
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${urunSepet.ad} sepetten silindi."),
                          ),
                        );
                      },

                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "http://kasimadalan.pe.hu/urunler/resimler/${urunSepet.resim}",
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          urunSepet.ad,
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          urunSepet.marka,
                                          style: TextStyle(
                                            color: textColor1,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "₺${(urunSepet.fiyat * urunSepet.siparisAdeti).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (urunSepet.siparisAdeti > 1) {
                                              context
                                                  .read<CartScreenCubit>()
                                                  .updateQuantity(
                                                    urunSepet.sepetId,
                                                    urunSepet.siparisAdeti - 1,
                                                  );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          color: mainColor,
                                          splashRadius: 20,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: mainColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            urunSepet.siparisAdeti.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<CartScreenCubit>()
                                                .updateQuantity(
                                                  urunSepet.sepetId,
                                                  urunSepet.siparisAdeti + 1,
                                                );
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
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
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      " Toplam : ${toplamTutar.toStringAsFixed(2)}₺",
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gradientButton(onPressed: () {}, text: "Siparişi Onayla"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
