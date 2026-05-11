import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD

=======
import 'package:http/http.dart' as http;
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6

import 'login_screen.dart';
import '../../../../data/service/register_service.dart';
import '../../../../data/models/user_model.dart';
import '../../../../features/customer/presentation/screens/tampilan_awal_page.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

<<<<<<< HEAD
Future<void> signInWithGoogle() async {
  try {

    GoogleAuthProvider authProvider =
        GoogleAuthProvider();

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(
      authProvider,
    );

    User? user = userCredential.user;

    if (user != null) {

      // KIRIM DATA KE PHP
      final response = await http.post(
        Uri.parse(
          "http://localhost/api_cashel/auth/google_login.php",
        ),
        body: {
          "nama": user.displayName ?? "",
          "email": user.email ?? "",
          "uid": user.uid,
        },
      );

      print(response.body);

      // NOTIF SUKSES
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Login berhasil!",
          ),
          backgroundColor: Colors.green,
=======
  Future<void> signInWithGoogle() async {
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(
        authProvider,
      );

      User? user = userCredential.user;

      if (user != null) {
        // KIRIM DATA KE PHP
        final response = await http.post(
          Uri.parse("http://localhost/api_cashel/auth/google_login.php"),
          body: {
            "nama": user.displayName ?? "",
            "email": user.email ?? "",
            "uid": user.uid,
          },
        );

        print(response.body);

        // NOTIF SUKSES
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Login berhasil!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        // PINDAH HALAMAN
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TampilanAwalPage(),
          ),
        );
      }
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google Sign-In gagal: $e"),
          backgroundColor: Colors.red,
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
<<<<<<< HEAD
          duration: const Duration(seconds: 2),
        ),
      );

      // PINDAH HALAMAN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TampilanAwalPage(),
        ),
      );
    }

  } catch (e) {

    print(e);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Google Sign-In gagal: $e",
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

  }
}
=======
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/register.png',
                    height: 180,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(height: 180, color: Colors.grey[200]),
                  ),
                ),
                const SizedBox(height: 15),
<<<<<<< HEAD
                const Text("Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                _buildTextField(
                    controller: _namaController,
                    hintText: "Nama Lengkap",
                    icon: Icons.person_outline),
                const SizedBox(height: 12),
                _buildTextField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 12),
                _buildTextField(
                    controller: _hpController,
                    hintText: "Nomor HP",
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone),
=======
                const Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _namaController,
                  hintText: "Nama Lengkap",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 12),

                _buildTextField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                _buildTextField(
                  controller: _hpController,
                  hintText: "Nomor HP",
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                const SizedBox(height: 12),

                _buildPasswordField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  toggleVisibility: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: 12),
<<<<<<< HEAD
=======

>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hintText: "Konfirmasi Password",
                  obscureText: _obscureConfirmPassword,
                  toggleVisibility: () => setState(
<<<<<<< HEAD
                      () => _obscureConfirmPassword = !_obscureConfirmPassword),
=======
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                ),
                const SizedBox(height: 20),

                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
                                  const SnackBar(
                                      content: Text("Password tidak cocok!")));
=======
                                const SnackBar(
                                  content: Text("Password tidak cocok!"),
                                ),
                              );
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                              return;
                            }

                            setState(() => _isLoading = true);
<<<<<<< HEAD
                            
=======

>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                            try {
                              RegisterService authService = RegisterService();
                              UserModel response = await authService.register(
                                nama: _namaController.text,
                                email: _emailController.text,
                                noHp: _hpController.text,
                                password: _passwordController.text,
                                alamat: "-",
                              );

                              if (!mounted) return;
                              setState(() => _isLoading = false);

                              if (response.status == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
                                    const SnackBar(
                                        content: Text("Registrasi Berhasil!")));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(response.message)));
=======
                                  const SnackBar(
                                    content: Text("Registrasi Berhasil!"),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response.message)),
                                );
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                              }
                            } catch (e) {
                              if (!mounted) return;
                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
                                  SnackBar(content: Text("Gagal terhubung ke server: $e")));
=======
                                SnackBar(
                                  content: Text("Gagal terhubung ke server: $e"),
                                ),
                              );
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B95DE),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
<<<<<<< HEAD
                              borderRadius: BorderRadius.circular(8)),
=======
                            borderRadius: BorderRadius.circular(8),
                          ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                        ),
                        child: const Text("Mendaftar"),
                      ),
                const SizedBox(height: 25),
<<<<<<< HEAD
                _buildDivider(),
                const SizedBox(height: 20),
                
                // TOMBOL SOSIAL MEDIA (Hanya UI, Tanpa Firebase)
                
_socialButton(
                  text: "Google",
                  iconAsset:
                      'assets/images/google-icon.png', // Pastikan file ini ada di folder assets
                  borderColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                  onTap: () async {
                    await signInWithGoogle(); // Fungsi login Google kamu
                  },
                ),
                const SizedBox(height: 20),
=======

                _buildDivider(),
                const SizedBox(height: 20),

                // TOMBOL SOSIAL MEDIA (Hanya UI, Tanpa Firebase)
                _socialButton(
                  text: "Google",
                  iconAsset: 'assets/images/google-icon.png',
                  borderColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                  onTap: () async {
                    await signInWithGoogle();
                  },
                ),
                const SizedBox(height: 20),

>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                _loginRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---
<<<<<<< HEAD
  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required IconData icon,
      TextInputType keyboardType = TextInputType.text}) {
=======
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty
          ? "$hintText tidak boleh kosong"
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFFDFDFD),
        border: OutlineInputBorder(
<<<<<<< HEAD
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[200]!)),
=======
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildPasswordField(
      {required TextEditingController controller,
      required String hintText,
      required bool obscureText,
      required VoidCallback toggleVisibility}) {
=======
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) => value == null || value.length < 6
          ? "Password minimal 6 karakter"
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
<<<<<<< HEAD
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey),
            onPressed: toggleVisibility),
        filled: true,
        fillColor: const Color(0xFFFDFDFD),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[200]!)),
=======
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: const Color(0xFFFDFDFD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
      ),
    );
  }

  Widget _buildDivider() {
<<<<<<< HEAD
    return const Row(children: [
      Expanded(child: Divider()),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Atau daftar menggunakan",
              style: TextStyle(color: Colors.grey, fontSize: 12))),
      Expanded(child: Divider()),
    ]);
  }

  Widget _socialButton({
  required String text,
  required String iconAsset, // Sekarang menggunakan path gambar
  required Color borderColor,
  required Color textColor,
  required VoidCallback onTap,
}) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconAsset, // Menampilkan logo Google/Facebook dari folder assets
            height: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
=======
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Atau daftar menggunakan",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _socialButton({
    required String text,
    required String iconAsset,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginRedirect() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Sudah punya akun? silahkan "),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
            child: const Text(
              "masuk",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
            ),
          ),
        ],
      ),
<<<<<<< HEAD
    ),
  );
}

  Widget _loginRedirect() {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Sudah punya akun? silahkan "),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())),
          child: const Text("masuk",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ]),
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
    );
  }
}