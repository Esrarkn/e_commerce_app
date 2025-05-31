import 'package:e_commerce_app/ui/components/gradientButton.dart';
import 'package:e_commerce_app/ui/screens/homeScreen.dart';
import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                buildPage(
                  image: 'assets/images/virtual-makeup-shopping.jpg',
                  title: 'Online Alışverişin\nKeyfini Çıkarın',
                  description: 'Trend ürünler ve seçkin markaların en iyi ürünleri hepsi tek uygulamada.',
                ),
                buildPage(
                  image: 'assets/images/shopping-bag-hands.jpg',
                  title: 'Tarzını Keşfet,\nSana Özel Öneriler',
                  description: 'Özenle seçilmiş ürünlerle sana özel bir alışveriş dünyası.',
                ),
                buildPage(
                  image: 'assets/images/sharing-credit-cards.jpg',
                  title: 'Hızlı Teslimat,\nGüvenli Alışveriş',
                  description: 'Güvenli ödeme seçenekleriyle alışverişinizi tamamlayın. ',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              activeDotColor: mainColor,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: gradientButton2(
                onPressed: () {
                  if (isLastPage) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) =>  HomeScreen()),
                      (route) => false,
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                text: isLastPage ? 'Başla' : 'İleri',
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.56,
          width: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: mainColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
