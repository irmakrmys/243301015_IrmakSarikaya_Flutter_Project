class Kitap{
  final String id;
  final String kitapadi;
  final String yazar;
  final String kategori;
  final String fiyat;
  final String gorsel;

  Kitap({
    required this.id,
    required this.kitapadi,
    required this.yazar,
    required this.kategori,
    required this.fiyat,
    required this.gorsel,
  });

  factory Kitap.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Kitap(
      id: documentId,
      kitapadi: data['kitap_adi'] ?? '',
      yazar: data['yazar'] ?? '',
      fiyat: data['fiyat'] ?? '',
      kategori: data['kategori'] ?? '',
      gorsel: data['gorsel'] ?? '',
    );
  }

}