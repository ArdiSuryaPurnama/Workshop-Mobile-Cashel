class ProdukModel {
  final int idProduk;
  final String namaProduk;
  final String deskripsi;
  final int harga;
  final int stok;
  final String gambar;
  final String? kategori;

  ProdukModel({
    required this.idProduk,
    required this.namaProduk,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.gambar,
    this.kategori,
  });

  // Mengubah JSON dari PHP menjadi Objek Dart
  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      idProduk: int.parse(json['id_produk'].toString()),
      namaProduk: json['nama_produk'],
      deskripsi: json['deskripsi'],
      harga: int.parse(json['harga'].toString()),
      stok: int.parse(json['stok'].toString()),
      gambar: json['gambar'],
      kategori: json['kategori'],
    );
  }

  // Mengubah Objek Dart menjadi JSON untuk dikirim ke PHP
  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'nama_produk': namaProduk,
      'deskripsi': deskripsi,
      'harga': harga,
      'stok': stok,
      'gambar': gambar,
      'kategori': kategori,
    };
  }
}