import 'package:e_commerce_app/data/entity/urunler.dart';
import 'package:e_commerce_app/ui/components/bottomNavBar.dart';
import 'package:e_commerce_app/ui/tools/kullanici.dart';
import 'package:e_commerce_app/ui/components/productCard.dart';
import 'package:e_commerce_app/ui/cubits/detailScreenCubit.dart';
import 'package:e_commerce_app/ui/cubits/homeScreenCubit.dart';
import 'package:e_commerce_app/ui/screens/cartScreen.dart';
import 'package:e_commerce_app/ui/screens/detailScreen.dart';
import 'package:e_commerce_app/ui/screens/favoriteScreen.dart';
import 'package:e_commerce_app/ui/screens/profileScreen.dart';
import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = "Tüm Ürünler";
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final urunlerListesi = context.watch<HomeScreenCubit>().state;
    final List<Widget> screens = [
      buildHomeBody(),
      FavoriteScreen(urun: urunlerListesi),
      const CartScreen(kullaniciAdi: kullanici_adi),
      const ProfileScreen(),
    ];
    final List<String> titles = ["Ana Sayfa", "Favoriler", "Sepet", "Profil"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold,fontFamily: "Inter",fontSize:25 ),
        ),
        centerTitle: true,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget buildHomeBody() {
    return Column(
      children: [
        SizedBox(
          height: 72,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              placeholder: "Ara",
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
                context.read<HomeScreenCubit>().searchAndFilter(
                  _searchQuery,
                  _selectedCategory,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kategoriler",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: mainColor,
                fontFamily: "Inter"
              ),
            ),
          ),
        ),
        BlocBuilder<HomeScreenCubit, List<Urunler>>(
          builder: (context, urunlerListesi) {
            if (urunlerListesi.isEmpty) {
              return const Expanded(
                child: Center(child: Text("Ürün bulunamadı")),
              );
            }

            final tumUrunler = context.read<HomeScreenCubit>().tumUrunler;
            final kategoriler = [
              "Tüm Ürünler",
              ...{for (var urun in tumUrunler) urun.kategori},
            ];

            final filtreliUrunler =
                _selectedCategory == "Tüm Ürünler"
                    ? urunlerListesi
                    : urunlerListesi
                        .where((urun) => urun.kategori == _selectedCategory)
                        .toList();

            return Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: kategoriler.length,
                      itemBuilder: (context, index) {
                        final kategori = kategoriler[index];
                        final bool secili = kategori == _selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: ChoiceChip(
                            label: Text(kategori,style: TextStyle(fontFamily: "Inter"),),
                            selected: secili,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = kategori;
                              });
                              context.read<HomeScreenCubit>().searchAndFilter(
                                _searchQuery,
                                kategori,
                              );
                            },
                            selectedColor: mainColor,
                            checkmarkColor: textColor2,
                            labelStyle: TextStyle(
                              color: secili ? Colors.white : mainColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.64,
                          ),
                      itemCount: filtreliUrunler.length,
                      itemBuilder: (context, index) {
                        final urun = filtreliUrunler[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(urun: urun),
                              ),
                            );
                          },
                          child: ProductCard(
                            urun: urun,
                            onAddToCart: () {
                              context.read<DetailScreenCubit>().addCart(
                                urun.ad,
                                urun.resim,
                                urun.kategori,
                                urun.fiyat,
                                urun.marka,
                                1,
                                kullanici_adi,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${urun.ad} sepete eklendi",style: TextStyle(fontFamily: "Inter"),),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
