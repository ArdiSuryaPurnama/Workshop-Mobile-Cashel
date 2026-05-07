import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Import file rincian pembatalan yang sudah Anda buat
import 'rincian_pembatalan_berhasil.dart'; 

class RincianPesananScreen extends StatefulWidget {
  final String metodePembayaran;
  final String namaProduk;
  final int harga;
  final String imagePath;
  final int jumlah;
  final int totalBayar;
  final int ongkir;

  const RincianPesananScreen({
    super.key,
    required this.metodePembayaran,
    required this.namaProduk,
    required this.harga,
    required this.imagePath,
    required this.jumlah,
    required this.totalBayar,
    required this.ongkir,
  });

  @override
  State<RincianPesananScreen> createState() => _RincianPesananScreenState();
}

class _RincianPesananScreenState extends State<RincianPesananScreen> {
  String? _selectedReason;
  late String _waktuFormatted;

  @override
  void initState() {
    super.initState();
    _waktuFormatted = DateFormat('dd-MM-yyyy HH.mm').format(DateTime.now());
  }

  // MODAL ALASAN PEMBATALAN
  void _showBatalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Text(
                    "Pilih Alasan Pembatalan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 16),
                  _buildReasonItem(setModalState, "Ingin mengubah alamat pengiriman"),
                  _buildReasonItem(setModalState, "Ingin mengubah rincian pesanan"),
                  _buildReasonItem(setModalState, "Menemukan harga yang lebih murah"),
                  _buildReasonItem(setModalState, "Lainnya"),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedReason == null
                          ? null
                          : () {
                              Navigator.pop(context); // Tutup pop-up
                              
                              // FIX: Mengirim data ke RincianPembatalanBerhasil agar tidak error
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RincianPembatalanBerhasil(
                                    namaProduk: widget.namaProduk,
                                    imagePath: widget.imagePath,
                                    jumlah: widget.jumlah,
                                    harga: widget.harga,
                                    alasan: _selectedReason!,
                                    waktuBatal: DateFormat('dd-MM-yyyy HH.mm').format(DateTime.now()),
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedReason == null ? Colors.grey[300] : const Color(0xFF3498DB),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: const Text("Konfirmasi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReasonItem(StateSetter setModalState, String reason) {
    return RadioListTile<String>(
      title: Text(reason, style: const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
      value: reason,
      groupValue: _selectedReason,
      activeColor: const Color(0xFF3498DB),
      contentPadding: EdgeInsets.zero,
      onChanged: (value) => setModalState(() => _selectedReason = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayMetode = (widget.metodePembayaran.toUpperCase() == "COD") ? "Tunai" : widget.metodePembayaran;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Rincian Pesanan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      // Gambar Produk
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(widget.imagePath, width: 60, height: 60, fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: Colors.grey[200], width: 60, height: 60)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.namaProduk, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'Poppins')),
                            Text("x${widget.jumlah}", style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Poppins')),
                          ],
                        ),
                      ),
                      Text("Rp${widget.harga}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Poppins')),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(thickness: 0.5)),
                  _buildPriceRow("Subtotal Produk", "Rp${widget.harga * widget.jumlah}"),
                  _buildPriceRow("Subtotal Pengiriman", "Rp${widget.ongkir}"),
                  _buildPriceRow("Biaya Layanan", "Rp0"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Pembayaran", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins')),
                      Text("Rp${widget.totalBayar}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF3498DB), fontFamily: 'Poppins')),
                    ],
                  ),
                ],
              ),
            ),
            _buildCard(
              child: Column(
                children: [
                  _buildInfoRow(Icons.location_on_outlined, "Alamat Pengiriman", 
                    "Jefri Nichol | (+62) 852 1234 8765\nJl A Yani, Kecamatan Nganjuk, Kabupaten Nganjuk, JAWA TIMUR"),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(thickness: 0.5)),
                  _buildInfoRow(Icons.payments_outlined, "Metode Pembayaran", displayMetode),
                ],
              ),
            ),
            _buildCard(
              child: Column(
                children: [
                  _buildPriceRow("No. Pesanan", "CSH070520261001"),
                  _buildPriceRow("Waktu Pemesanan", _waktuFormatted),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _showBatalBottomSheet,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Batalkan Pesanan", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'Poppins')),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Poppins')),
              const SizedBox(height: 4),
              Text(content, style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.4, fontFamily: 'Poppins')),
            ],
          ),
        ),
      ],
    );
  }
}