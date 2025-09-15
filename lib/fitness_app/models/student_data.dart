class StudentData {
  StudentData({
    this.imagePath = '',
    this.nisn = '',
    this.namaLengkap = '',
    this.jenisKelamin = '',
    this.agama = '',
    this.tempatLahir = '',
    this.tanggalLahir = '',
    this.nomorTlp = '',
    this.nik = '',
   Alamat? alamat,
    OrangTua? orangTua,
    this.startColor = '',
    this.endColor = '',
  }): alamat = alamat ?? Alamat(),
        orangTua = orangTua ?? OrangTua();

  String imagePath;
  String nisn;
  String namaLengkap;
  String jenisKelamin;
  String agama;
  String tempatLahir;
  String tanggalLahir;
  String nomorTlp;
  String nik;
  Alamat alamat;
  OrangTua orangTua;
  String startColor;
  String endColor;

  static List<StudentData> studentsList = <StudentData>[
    StudentData(
      imagePath: 'assets/fitness_app/breakfast.png',
      nisn: '1234567890',
      namaLengkap: 'Ahmad Rizki Pratama',
      jenisKelamin: 'Laki-laki',
      agama: 'Islam',
      tempatLahir: 'Jakarta',
      tanggalLahir: '15 Januari 2005',
      nomorTlp: '081234567890',
      nik: '3171011501050001',
      alamat: Alamat(
        jalan: 'Jl. Merdeka No. 123',
        rtRw: '001/005',
        dusun: 'Dusun Merdeka',
        desa: 'Desa Sukamaju',
        kecamatan: 'Kecamatan Sukajadi',
        kabupaten: 'Kabupaten Bogor',
        provinsi: 'Jawa Barat',
        kodePos: '16110',
      ),
      orangTua: OrangTua(
        namaAyah: 'Budi Santoso',
        namaIbu: 'Siti Aminah',
        namaWali: '',
        alamat:
            'Jl. Merdeka No. 123, RT 001/005, Dusun Merdeka, Desa Sukamaju, Kecamatan Sukajadi, Kabupaten Bogor, Jawa Barat 16110',
      ),
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    StudentData(
      imagePath: 'assets/fitness_app/lunch.png',
      nisn: '1234567891',
      namaLengkap: 'Siti Nurhaliza',
      jenisKelamin: 'Perempuan',
      agama: 'Islam',
      tempatLahir: 'Bandung',
      tanggalLahir: '22 Maret 2005',
      nomorTlp: '081234567891',
      nik: '3171012203050002',
      alamat: Alamat(
        jalan: 'Jl. Pahlawan No. 456',
        rtRw: '002/006',
        dusun: 'Dusun Pahlawan',
        desa: 'Desa Sukasari',
        kecamatan: 'Kecamatan Sukamaju',
        kabupaten: 'Kabupaten Bandung',
        provinsi: 'Jawa Barat',
        kodePos: '16111',
      ),
      orangTua: OrangTua(
        namaAyah: 'Ahmad Wijaya',
        namaIbu: 'Rina Sari',
        namaWali: '',
        alamat:
            'Jl. Pahlawan No. 456, RT 002/006, Dusun Pahlawan, Desa Sukasari, Kecamatan Sukamaju, Kabupaten Bandung, Jawa Barat 16111',
      ),
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    StudentData(
      imagePath: 'assets/fitness_app/snack.png',
      nisn: '1234567892',
      namaLengkap: 'Budi Santoso',
      jenisKelamin: 'Laki-laki',
      agama: 'Kristen',
      tempatLahir: 'Surabaya',
      tanggalLahir: '10 Mei 2005',
      nomorTlp: '081234567892',
      nik: '3171011005050003',
      alamat: Alamat(
        jalan: 'Jl. Kemerdekaan No. 789',
        rtRw: '003/007',
        dusun: 'Dusun Kemerdekaan',
        desa: 'Desa Sukamakmur',
        kecamatan: 'Kecamatan Sukabumi',
        kabupaten: 'Kabupaten Sukabumi',
        provinsi: 'Jawa Barat',
        kodePos: '16112',
      ),
      orangTua: OrangTua(
        namaAyah: 'Joko Widodo',
        namaIbu: 'Maya Sari',
        namaWali: 'Dedi Mulyadi',
        alamat:
            'Jl. Kemerdekaan No. 789, RT 003/007, Dusun Kemerdekaan, Desa Sukamakmur, Kecamatan Sukabumi, Kabupaten Sukabumi, Jawa Barat 16112',
      ),
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    StudentData(
      imagePath: 'assets/fitness_app/dinner.png',
      nisn: '1234567893',
      namaLengkap: 'Maya Sari Dewi',
      jenisKelamin: 'Perempuan',
      agama: 'Hindu',
      tempatLahir: 'Denpasar',
      tanggalLahir: '05 Agustus 2005',
      nomorTlp: '081234567893',
      nik: '3171010508050004',
      alamat: Alamat(
        jalan: 'Jl. Kebangsaan No. 321',
        rtRw: '004/008',
        dusun: 'Dusun Kebangsaan',
        desa: 'Desa Sukajaya',
        kecamatan: 'Kecamatan Sukamaju',
        kabupaten: 'Kabupaten Cianjur',
        provinsi: 'Jawa Barat',
        kodePos: '16113',
      ),
      orangTua: OrangTua(
        namaAyah: 'I Made Surya',
        namaIbu: 'Ni Ketut Sari',
        namaWali: '',
        alamat:
            'Jl. Kebangsaan No. 321, RT 004/008, Dusun Kebangsaan, Desa Sukajaya, Kecamatan Sukamaju, Kabupaten Cianjur, Jawa Barat 16113',
      ),
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}

class Alamat {
  Alamat({
    this.jalan = '',
    this.rtRw = '',
    this.dusun = '',
    this.desa = '',
    this.kecamatan = '',
    this.kabupaten = '',
    this.provinsi = '',
    this.kodePos = '',
  });

  String jalan;
  String rtRw;
  String dusun;
  String desa;
  String kecamatan;
  String kabupaten;
  String provinsi;
  String kodePos;
}

class OrangTua {
  OrangTua({
    this.namaAyah = '',
    this.namaIbu = '',
    this.namaWali = '',
    this.alamat = '',
  });

  String namaAyah;
  String namaIbu;
  String namaWali;
  String alamat;
}
