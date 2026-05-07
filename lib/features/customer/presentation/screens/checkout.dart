import 'package:flutter/material.dart';
import '../widgets/checkout_widgets.dart'; // Naik ke presentation/widgets
import 'pembayaran_qris_page.dart';        // Tetap di folder screens
import 'pesanan_diterima.dart';           // Tetap di folder screens

class CheckoutPage extends StatefulWidget {
  // Parameter untuk menerima data produk secara realtime
  final String namaProduk;
  final int harga;
  final String imagePath;
  final int jumlah;

  const CheckoutPage({
    super.key,
    required this.namaProduk,
    required this.harga,
    required this.imagePath,
    required this.jumlah,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _paymentMethod = 'Tunai'; // Default 'Tunai'
  String _deliveryOption = 'Diantar';

  // Perhitungan otomatis berdasarkan widget parameter
  int get _subtotalProduk => widget.harga * widget.jumlah;
  int get _ongkir => _deliveryOption == 'Diantar' ? 1000 : 0;
  int get _totalBayar => _subtotalProduk + _ongkir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alamat Pengiriman
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.black, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Jefri Nichol ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          fontFamily: 'Poppins'),
                                    ),
                                    TextSpan(
                                      text: '(+62) 852 1234 8765',
                                      style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 12,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Jl A Yani, Kecamatan Nganjuk, Kabupaten Nganjuk, JAWA TIMUR',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF444444),
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionDivider(),

                  // Toko dan Produk
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Star+',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'CASHEL',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                widget.imagePath,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.namaProduk,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12, fontFamily: 'Poppins'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rp${widget.harga}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'x${widget.jumlah}',
                              style: const TextStyle(
                                  color: Color(0xFF888888), fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SectionDivider(),

                  // Opsi Pengiriman
                  _buildSectionTitle('Opsi Pengiriman'),
                  _buildOptionTile(
                    'Diantar',
                    'Rp.1000',
                    _deliveryOption == 'Diantar',
                    () => setState(() => _deliveryOption = 'Diantar'),
                  ),
                  _buildOptionTile(
                    'Ambil sendiri',
                    'Rp.0',
                    _deliveryOption == 'Ambil sendiri',
                    () => setState(() => _deliveryOption = 'Ambil sendiri'),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total ${widget.jumlah} Produk',
                          style: const TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                        ),
                        Text(
                          'Rp$_subtotalProduk',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  const SectionDivider(),

                  // Metode Pembayaran
                  _buildSectionTitle('Metode Pembayaran'),
                  _buildPaymentTile(
                    'Tunai',
                    'assets/images/cash.png',
                    _paymentMethod == 'Tunai',
                  ),
                  _buildPaymentTile(
                    'QRIS',
                    'assets/images/qris_bayar.png',
                    _paymentMethod == 'QRIS',
                  ),
                  const SectionDivider(),

                  // Rincian Pembayaran
                  _buildSectionTitle('Rincian Pembayaran'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        RincianRow(
                            label: 'Subtotal Pesanan', value: 'Rp$_subtotalProduk'),
                        RincianRow(
                            label: 'Subtotal Pengiriman', value: 'Rp$_ongkir'),
                        const RincianRow(label: 'Biaya Layanan', value: 'Rp0'),
                        const SizedBox(height: 8),
                        const SectionDivider(),
                        RincianRow(
                          label: 'Total Pembayaran',
                          value: 'Rp$_totalBayar',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Tombol Bawah
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFFEAF3FF),
              border: Border(top: BorderSide(color: Color(0xFFD1E4FF))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    children: [
                      const TextSpan(text: 'Total ', style: TextStyle(fontSize: 12)),
                      TextSpan(
                        text: 'Rp$_totalBayar',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_paymentMethod == 'QRIS') {
                      // PERBAIKAN: Mengirimkan data realtime ke PembayaranQRISPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PembayaranQRISPage(
                            namaProduk: widget.namaProduk,
                            harga: widget.harga,
                            imagePath: widget.imagePath,
                            jumlah: widget.jumlah,
                            totalBayar: _totalBayar,
                            ongkir: _ongkir,
                          ),
                        ),
                      );
                    } else {
                      // Data dialirkan secara realtime ke halaman berikutnya untuk Tunai
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PesananDiterimaPage(
                            metodePembayaran: _paymentMethod,
                            namaProduk: widget.namaProduk,
                            harga: widget.harga,
                            imagePath: widget.imagePath,
                            jumlah: widget.jumlah,
                            totalBayar: _totalBayar,
                            ongkir: _ongkir,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Buat Pesanan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Poppins'),
      ),
    );
  }

  Widget _buildOptionTile(
      String title, String price, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? const Color(0xFF3498DB) : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontFamily: 'Poppins')),
            Text(price,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins')),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTile(String title, String assetPath, bool isSelected) {
    return ListTile(
      onTap: () => setState(() => _paymentMethod = title),
      leading: Image.asset(assetPath, width: 24, height: 24,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.payments_outlined, size: 24)),
      title: Text(title, style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_off,
        color: isSelected ? const Color(0xFF3498DB) : const Color(0xFFD1D1D1),
        size: 22,
      ),
    );
  }
}