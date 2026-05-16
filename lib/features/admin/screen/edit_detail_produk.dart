import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import '../../../data/models/produk_model.dart';

class EditDetailProduk extends StatefulWidget {
  final ProdukModel? produk;
  const EditDetailProduk({super.key, this.produk});

  @override
  State<EditDetailProduk> createState() => _EditDetailProdukState();
}

class _EditDetailProdukState extends State<EditDetailProduk> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _namaController;
  late TextEditingController _hargaController;
  late TextEditingController _stokController;
  late TextEditingController _descController;

  bool _isEditMode = false;

  String _gambarTerpilih = "default.png";

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.produk != null;
    
    _namaController = TextEditingController(text: _isEditMode ? widget.produk!.namaProduk : "");
    _hargaController = TextEditingController(text: _isEditMode ? widget.produk!.harga.toString() : "");
    _stokController = TextEditingController(text: _isEditMode ? widget.produk!.stok.toString() : "");
    _descController = TextEditingController(text: _isEditMode ? widget.produk!.deskripsi : "");
  
  _gambarTerpilih = _isEditMode ? widget.produk!.gambar : "default.png";
}

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      String url = _isEditMode
          ? "http://192.168.1.7/api_cashel/api_stok/update_produk.php"
          : "http://192.168.1.7/api_cashel/api_stok/tambah_produk.php";

      var requestBody = {
        "nama_produk": _namaController.text,
        "harga": _hargaController.text,
        "stok": _stokController.text,
        "deskripsi": _descController.text,
        "gambar": _gambarTerpilih,
        "kategori": "Alat Tulis",
      };

      if (_isEditMode) {
        requestBody["id_produk"] = widget.produk!.idProduk.toString();
      }

      final response = await http.post(Uri.parse(url), body: requestBody);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil disimpan!")));
        Navigator.pop(context, true);
      }
    }
  }

  // Fungsi pembantu untuk aksi ganti gambar saat tombol pensil ditekan
  void _pilihGambar() {
    // SINKRONISASI LOGIKA: Tempatkan kode ImagePicker kamu di sini nanti
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fitur ganti gambar dipicu!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. MENGUBAH BACKGROUND MENJADI PUTIH
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _isEditMode ? "Edit Produk" : "Tambah Produk Baru",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 2. AREA GAMBAR PRODUK DINAMIS (SUDAH BERSIH & FIX)
Center(
                child: Stack(
                  children: [
                    // Bingkai Foto Utama
                    Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child:
                            _gambarTerpilih.isNotEmpty &&
                                _gambarTerpilih != "default.png"
                            // Menampilkan gambar berdasarkan file yang sedang terpilih di variabel _gambarTerpilih
                            ? Image.asset(
                                'assets/images/$_gambarTerpilih',
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) {
                                  print(
                                    "❌ KATA KUNCI ERROR: File assets/images/$_gambarTerpilih tidak ditemukan!",
                                  );
                                  return const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              )
                            // Jika data kosong atau default, tampilkan placeholder kamera pink
                            : const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.pink,
                                ),
                              ),
                      ),
                    ),
                    // Tombol Bulat Ikon Pensil di Pojok Kanan Bawah
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();

                          // Membuka Galeri Foto HP
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 70,
                          );

                          if (image != null) {
                            String namaFileGambar = image.name;

                            setState(() {
                              _gambarTerpilih =
                                  namaFileGambar; // Set nama file baru ke variabel state
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Gambar terpilih: $namaFileGambar",
                                ),
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(
                            0xFF2196F3,
                          ), // Biru figma
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // Field Input Nama
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: "Nama Produk", 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              const SizedBox(height: 15),
              
              // Field Input Harga
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga (Rp)", 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              const SizedBox(height: 15),

              // Field Input Stok
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Jumlah Stok", 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => v!.isEmpty ? "Harus diisi" : null,
              ),
              const SizedBox(height: 15),

              // Field Deskripsi
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk", 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3), // Warna Biru Figma
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26), // Membuat tombol melengkung penuh (capsule style)
                    ),
                    elevation: 0,
                  ),
                  onPressed: _saveData,
                  child: const Text(
                    "SIMPAN PRODUK", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}