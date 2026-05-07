import 'package:flutter/material.dart';

class AkunProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imagePath;
  final VoidCallback onEditName;
  final VoidCallback onEditPhoto;

  const AkunProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imagePath,
    required this.onEditName,
    required this.onEditPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        children: [
          // Foto Profil bisa diklik untuk ganti gambar
          GestureDetector(
            onTap: onEditPhoto,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt, size: 12, color: Colors.black54),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF181725),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Icon Pensil yang berfungsi
                    GestureDetector(
                      onTap: onEditName,
                      child: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF3498DB)),
                    ),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AkunMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const AkunMenuItem({super.key, required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2)),
        ListTile(
          onTap: onTap,
          leading: const Icon(Icons.list_alt_outlined, color: Color(0xFF181725)),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF181725),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF181725)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        ),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: double.infinity,
        height: 67,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: const Color(0xFFF01F0E).withOpacity(0.7), width: 1.2),
        ),
        child: InkWell(
          onTap: () {
            // Logout logic
          },
          borderRadius: BorderRadius.circular(19),
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Positioned(
                left: 25,
                child: Icon(Icons.logout, color: Color(0xFFF01F0E)),
              ),
              Text(
                'Log Out',
                style: TextStyle(
                  color: Color(0xFFF01F0E),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}