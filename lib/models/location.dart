class LocationEntry {
  final String dusun;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;
  final String kodePos;

  LocationEntry({
    required this.dusun,
    required this.desa,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
    required this.kodePos,
  });

  factory LocationEntry.fromJson(Map<String, dynamic> json) => LocationEntry(
    dusun: json['dusun'] ?? '',
    desa: json['desa'] ?? '',
    kecamatan: json['kecamatan'] ?? '',
    kabupaten: json['kabupaten'] ?? '',
    provinsi: json['provinsi'] ?? '',
    kodePos: json['kode_pos'] ?? '',
  );
}
