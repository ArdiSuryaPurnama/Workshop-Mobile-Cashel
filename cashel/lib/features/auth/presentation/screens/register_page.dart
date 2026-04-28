import 'package:flutter/material.dart';
import 'login_screen.dart'; // Pastikan file ini ada dan berisi LoginPage

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // GlobalKey untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil data input
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State untuk visibilitas password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Agar halaman bisa di-scroll saat keyboard muncul
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                
                // --- 1. GAMBAR ILUSTRASI ---
                Center(
                  child: Image.network(
                    'https://via.placeholder.com/250x180.png?text=Registrasi+Ilustrasi', // Ganti dengan asset lokal kamu
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15),

                // --- 2. JUDUL ---
                Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // --- 3. INPUT FIELDS ---
                // Nama Lengkap
                _buildTextField(
                  controller: _namaController,
                  hintText: "Nama Lengkap",
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 12),

                // Email
                _buildTextField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12),

                // Nomor HP
                _buildTextField(
                  controller: _hpController,
                  hintText: "Nomor HP",
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 12),

                // Password
                _buildPasswordField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  toggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                SizedBox(height: 12),

                // Konfirmasi Password
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hintText: "Konfirmasi Password",
                  obscureText: _obscureConfirmPassword,
                  toggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                SizedBox(height: 20),

                // --- 4. TOMBOL MENDAFTAR (BIRU) ---
                ElevatedButton(
                 onPressed: () {
  // 1. Validasi form (supaya tidak kosong)
  if (_formKey.currentState!.validate()) {
    
    // 2. Pindah ke halaman Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), 
    );
    
  }
},
                  child: Text("Mendaftar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B95DE), // Warna biru di gambar
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                ),
                SizedBox(height: 25),

                // --- 5. PEMISAH 'ATAU DAFTAR MENGGUNAKAN' ---
                _buildDivider(),
                SizedBox(height: 20),

                // --- 6. TOMBOL GOOGLE & FACEBOOK (Garis) ---
                // --- TOMBOL GOOGLE MANUAL ---
Container(
  width: double.infinity,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.red), 
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.g_mobiledata, color: Colors.red, size: 40),
      SizedBox(width: 10),
      Text("Google", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    ],
  ),
),

const SizedBox(height: 15), // Kasih jarak

// --- TOMBOL FACEBOOK MANUAL ---
Container(
  width: double.infinity,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue), 
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.facebook, color: Colors.blue, size: 30),
      SizedBox(width: 10),
      Text("Facebook", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
    ],
  ),
),

                // --- 7. TULISAN SUDAH PUNYA AKUN ---
              Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Sudah punya akun? silahkan "),
      GestureDetector(
        onTap: () {
          // Ini adalah perintah untuk pindah ke halaman Login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()), // Sesuaikan nama Class Login kamu
          );
        },
        child: const Text(
          "masuk",
          style: TextStyle(
            color: Colors.blue, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER AGAR KODE RAPI ---

  // Input Field Biasa
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Color(0xFFFDFDFD), // Sedikit abu-abu muda
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }

  // Input Field Password (dengan tombol mata)
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Color(0xFFFDFDFD),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
    );
  }

  // Garis Pemisah "Atau daftar menggunakan"
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("Atau daftar menggunakan", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
      ],
    );
  }
}