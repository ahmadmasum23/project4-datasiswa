class Student {
  final String? id;
  final String nisn;
  final String namaLengkap;
  final String jenisKelamin;
  final String agama;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String nomorTlp;
  final String nik;

  // Alamat
  final String jalan;
  final String rtRw;
  final String dusun;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;
  final String kodePos;

  // Orang Tua/Wali
  final String namaAyah;
  final String namaIbu;
  final String? namaWali;
  final String alamatOrangTua;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;

  Student({
    this.id,
    required this.nisn,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.agama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.nomorTlp,
    required this.nik,
    required this.jalan,
    required this.rtRw,
    required this.dusun,
    required this.desa,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
    required this.kodePos,
    required this.namaAyah,
    required this.namaIbu,
    this.namaWali,
    required this.alamatOrangTua,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']?.toString(),
      nisn: json['nisn'] ?? '',
      namaLengkap: json['nama_lengkap'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      agama: json['agama'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      nomorTlp: json['nomor_tlp'] ?? '',
      nik: json['nik'] ?? '',
      jalan: json['jalan'] ?? '',
      rtRw: json['rt_rw'] ?? '',
      dusun: json['dusun'] ?? '',
      desa: json['desa'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      kabupaten: json['kabupaten'] ?? '',
      provinsi: json['provinsi'] ?? '',
      kodePos: json['kode_pos'] ?? '',
      namaAyah: json['nama_ayah'] ?? '',
      namaIbu: json['nama_ibu'] ?? '',
      namaWali: json['nama_wali'],
      alamatOrangTua: json['alamat_orang_tua'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      createdBy: json['created_by']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nisn': nisn,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'agama': agama,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'nomor_tlp': nomorTlp,
      'nik': nik,
      'jalan': jalan,
      'rt_rw': rtRw,
      'dusun': dusun,
      'desa': desa,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
      'provinsi': provinsi,
      'kode_pos': kodePos,
      'nama_ayah': namaAyah,
      'nama_ibu': namaIbu,
      'nama_wali': namaWali,
      'alamat_orang_tua': alamatOrangTua,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }

  Student copyWith({
    String? id,
    String? nisn,
    String? namaLengkap,
    String? jenisKelamin,
    String? agama,
    String? tempatLahir,
    DateTime? tanggalLahir,
    String? nomorTlp,
    String? nik,
    String? jalan,
    String? rtRw,
    String? dusun,
    String? desa,
    String? kecamatan,
    String? kabupaten,
    String? provinsi,
    String? kodePos,
    String? namaAyah,
    String? namaIbu,
    String? namaWali,
    String? alamatOrangTua,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
  }) {
    return Student(
      id: id ?? this.id,
      nisn: nisn ?? this.nisn,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      agama: agama ?? this.agama,
      tempatLahir: tempatLahir ?? this.tempatLahir,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      nomorTlp: nomorTlp ?? this.nomorTlp,
      nik: nik ?? this.nik,
      jalan: jalan ?? this.jalan,
      rtRw: rtRw ?? this.rtRw,
      dusun: dusun ?? this.dusun,
      desa: desa ?? this.desa,
      kecamatan: kecamatan ?? this.kecamatan,
      kabupaten: kabupaten ?? this.kabupaten,
      provinsi: provinsi ?? this.provinsi,
      kodePos: kodePos ?? this.kodePos,
      namaAyah: namaAyah ?? this.namaAyah,
      namaIbu: namaIbu ?? this.namaIbu,
      namaWali: namaWali ?? this.namaWali,
      alamatOrangTua: alamatOrangTua ?? this.alamatOrangTua,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
