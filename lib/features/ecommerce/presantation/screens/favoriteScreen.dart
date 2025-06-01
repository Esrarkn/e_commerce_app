import 'package:e_commerce_app/ui/ecommerce/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/ecommerce/entity/urunler.dart';
import '../components/productCard.dart'; 

class FavoriteScreen extends StatefulWidget {
  final List<Urunler> urun;

  const FavoriteScreen({super.key, required this.urun});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Urunler> favoriUrunler = [];

  @override
  void initState() {
    super.initState();
    _favoriUrunleriGetir();
  }

  Future<void> _favoriUrunleriGetir() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriIdListesi = prefs.getStringList('favoriler') ?? [];

    setState(() {
      favoriUrunler = widget.urun.where(
        (urun) => favoriIdListesi.contains(urun.id.toString())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (favoriUrunler.isEmpty) {
      return const Center(
        child: Text("Favorilere eklenmiş ürün yok"),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 3,
        mainAxisSpacing: 10,
        childAspectRatio: 0.64,
      ),
      itemCount: favoriUrunler.length,
      itemBuilder: (context, index) {
        final urun = favoriUrunler[index];
return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailScreen(urun:urun)));
      },
  child: Padding(
    padding: const EdgeInsets.only(left: 5.0,right: 5),
    child: ProductCard(
      urun: urun,
      isFavorite: true,
      onAddToCart: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${urun.ad} sepete eklendi")),
        );
      },
      onRemoveFromFavorites: () async {
        final prefs = await SharedPreferences.getInstance();
        List<String> favoriIdListesi = prefs.getStringList('favoriler') ?? [];
    
        favoriIdListesi.remove(urun.id.toString());
        await prefs.setStringList('favoriler', favoriIdListesi);
    
        setState(() {
          favoriUrunler.removeAt(index);
        });
    
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${urun.ad} favorilerden çıkarıldı")),
        );
      },
    ),
  ),
);

      },
    );
  }
}
