import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            SizedBox(height: 8,),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"), // örnek
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock, size: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
             Center(
              child: Text(
                "Esra Arıkan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: mainColor),
              ),
            ),
             Center(
              child: Text(
                "esraarikan@gmail.com",
                style: TextStyle(color: textColor1),
              ),
            ),
            const SizedBox(height: 32),

            const Text("Hesap", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildListTile(icon: Icons.settings, color: Colors.grey, text: "Ayarlar"),
            _buildListTile(icon: Icons.notifications_none, color: Colors.tealAccent, text: "Bildirimler"),
            _buildListTile(icon: Icons.history, color: Colors.orangeAccent, text: "Sipariş Geçmişi"),

            const SizedBox(height: 24),
            const Text("Genel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildListTile(icon: Icons.lock_outline, color: Colors.lightBlueAccent, text: "Gizlilik ve Politika"),
            _buildListTile(icon: Icons.warning_amber_outlined, color: Colors.amber, text: "Şartlar ve Koşullar"),
            _buildListTile(icon: Icons.logout, color: Colors.redAccent, text: "Çıkış Yap"),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: color),
      ),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
