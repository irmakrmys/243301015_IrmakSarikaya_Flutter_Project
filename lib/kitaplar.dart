
class Kitaplarbilgi{
  final int id;
  final int sayfa_sayisi;
  final String yazaradi;
  final String kitap_adi;
  final String dil;
  final double  fiyat;
  final String resim;
  final String kategori;
  Kitaplarbilgi(this.id,this.dil,this.fiyat,this.kategori,this.kitap_adi,this.resim,this.sayfa_sayisi,this.yazaradi);

}
 class Kategori{
  final int id;
  final String kitap_adi;
  Kategori(this.kitap_adi,this.id);
 }
