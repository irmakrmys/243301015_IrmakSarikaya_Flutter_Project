import 'package:cloud_firestore/cloud_firestore.dart';

final List<Map<String, dynamic>> hocaninGorecegiKitaplar = [
  {
    'kitapadi': 'Büyük Umutlar',
    'yazar': 'Charles Dickens',
    'fiyat': '220',
    'kategori': 'Roman',
    'gorsel': 'https://1k-cdn.com/resimler/kitaplar/39535_haZTL_1518117589.jpg'
  },
  {
    'kitapadi': 'Oliver Twist',
    'yazar': 'Charles Dickens',
    'fiyat': '185',
    'kategori': 'Roman',
    'gorsel': 'https://m.media-amazon.com/images/I/81PpW3frJZL._AC_UF894,1000_QL80_.jpg'
  },
  {
    'kitapadi': 'Bir Noel Şarkısı',
    'yazar': 'Charles Dickens',
    'fiyat': '145',
    'kategori': 'Roman',
    'gorsel': 'https://www.nezih.com.tr/bir-noel-sarkisi-hay-179279-95-B.jpg'
  },
  {
    'kitapadi': 'Kavim',
    'yazar': 'Ahmet Ümit',
    'fiyat': '400',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Masal Masal İçinde',
    'yazar': 'Ahmet Ümit',
    'fiyat': '265',
    'kategori': 'Çocuk',
    'gorsel': ''
  },
  {
    'kitapadi': 'Harry Potter ve Felsefe Taşı',
    'yazar': 'J.K. Rowling',
    'fiyat': '330',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Harry Potter ve Ateş Kadehi',
    'yazar': 'J.K. Rowling',
    'fiyat': '290',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'İyilik Timi',
    'yazar': 'Michael Connelly',
    'fiyat': '125.9',
    'kategori': 'Çocuk',
    'gorsel': ''
  },
  {
    'kitapadi': 'Söyleme Bilmesinler',
    'yazar': 'Şermin Yaşar',
    'fiyat': '195',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': '1984',
    'yazar': 'George Orwell',
    'fiyat': '110.9',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Mavi Kuş',
    'yazar': 'Mustafa Kutlu',
    'fiyat': '100',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Denemeler',
    'yazar': 'Michel de Montaigne',
    'fiyat': '120',
    'kategori': 'Deneme',
    'gorsel': ''
  },
  {
    'kitapadi': 'İnsanın Anlam Arayışı',
    'yazar': 'Viktor E. Frankl',
    'fiyat': '149.9',
    'kategori': 'Deneme',
    'gorsel': ''
  },
  {
    'kitapadi': 'İrade Terbiyesi',
    'yazar': 'Jules Payot',
    'fiyat': '165',
    'kategori': 'Deneme',
    'gorsel': ''
  },
  {
    'kitapadi': 'Çanlar Kimin İçin Çalıyor',
    'yazar': 'Ernest Hemingway',
    'fiyat': '115',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Yüzyıllık Yalnızlık',
    'yazar': 'Gabriel García Márquez',
    'fiyat': '140',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Sırça Fanus',
    'yazar': 'Sylvia Plath',
    'fiyat': '219.9',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Temmuz Elması',
    'yazar': 'Gülten Dayıoğlu',
    'fiyat': '112',
    'kategori': 'Çocuk',
    'gorsel': ''
  },
  {
    'kitapadi': 'Bir Genç Kızın Gizli Defteri',
    'yazar': 'İpek Ongun',
    'fiyat': '185.9',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Yüzüklerin Efendisi',
    'yazar': 'J.R.R. Tolkien',
    'fiyat': '350',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Dune',
    'yazar': 'Frank Herbert',
    'fiyat': '600',
    'kategori': 'Roman',
    'gorsel': ''
  },
  {
    'kitapadi': 'Feyzül Furkan Kuran Meali',
    'yazar': 'Hasan Tahsin Feyizli',
    'fiyat': '700',
    'kategori': 'Din',
    'gorsel': ''
  },
  {
    'kitapadi': 'Türklerin Tarihi',
    'yazar': 'İlber Ortaylı',
    'fiyat': '125',
    'kategori': 'Tarih',
    'gorsel': ''
  },
  {
    'kitapadi': 'Akıllı Türk Makul Tarih',
    'yazar': 'Ahmet Almaz',
    'fiyat': '90',
    'kategori': 'Tarih',
    'gorsel': ''
  },
  {
    'kitapadi': 'Çürümenin Kitabı',
    'yazar': 'Emil Michel Cioran',
    'fiyat': '135.9',
    'kategori': 'Deneme',
    'gorsel': ''
  },
  {
    'kitapadi': 'İki Şehrin Hikayesi',
    'yazar': 'Charles Dickens',
    'fiyat': '300',
    'kategori': 'Roman',
    'gorsel': ''
  },
];
Future<void> kitaplariOtomatikYukle() async {
  final koleksiyon = FirebaseFirestore.instance.collection('kitaplar');


  final mevcutKitaplar = await koleksiyon.limit(1).get();
  if (mevcutKitaplar.docs.isNotEmpty) {
    print("Veritabanı zaten dolu");
    return;
  }

  print("Kitaplar yeni sayfadan yükleniypr..");
  for (var kitap in hocaninGorecegiKitaplar) {
    try {
      await koleksiyon.add({
        'kitapadi': kitap['kitapadi'],
        'yazar': kitap['yazar'],
        'fiyat': kitap['fiyat'],
        'kategori': kitap['kategori'],
        'gorsel': kitap['gorsel'],
        'tarih': DateTime.now(),
      });
      print("${kitap['kitapadi']}  yüklendi.");
    } catch (e) {
      print("Yükleme hatası: $e");
    }
  }
  print("TÜM KİTAPLAR YÜKLENDİ!");
}


