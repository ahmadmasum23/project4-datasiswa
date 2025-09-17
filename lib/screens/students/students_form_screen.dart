import 'package:flutter/material.dart';
import 'package:project4/models/student.dart';
import 'package:project4/services/students_service.dart';

class StudentsFormScreen extends StatefulWidget {
  final Student? student;
  const StudentsFormScreen({super.key, this.student});

  @override
  State<StudentsFormScreen> createState() => _StudentsFormScreenState();
}

class _StudentsFormScreenState extends State<StudentsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  final TextEditingController _nisn = TextEditingController();
  final TextEditingController _namaLengkap = TextEditingController();
  String _jenisKelamin = 'Laki-laki';
  final TextEditingController _agama = TextEditingController();
  final TextEditingController _tempatLahir = TextEditingController();
  DateTime? _tanggalLahir;
  final TextEditingController _nomorTlp = TextEditingController();
  final TextEditingController _nik = TextEditingController();
  final TextEditingController _jalan = TextEditingController();
  final TextEditingController _rtRw = TextEditingController();
  final TextEditingController _dusun = TextEditingController();
  final TextEditingController _desa = TextEditingController();
  final TextEditingController _kecamatan = TextEditingController();
  final TextEditingController _kabupaten = TextEditingController();
  final TextEditingController _provinsi = TextEditingController();
  final TextEditingController _kodePos = TextEditingController();
  final TextEditingController _namaAyah = TextEditingController();
  final TextEditingController _namaIbu = TextEditingController();
  final TextEditingController _namaWali = TextEditingController();
  final TextEditingController _alamatOrtu = TextEditingController();

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    if (s != null) {
      _nisn.text = s.nisn;
      _namaLengkap.text = s.namaLengkap;
      _jenisKelamin = s.jenisKelamin;
      _agama.text = s.agama;
      _tempatLahir.text = s.tempatLahir;
      _tanggalLahir = s.tanggalLahir;
      _nomorTlp.text = s.nomorTlp;
      _nik.text = s.nik;
      _jalan.text = s.jalan;
      _rtRw.text = s.rtRw;
      _dusun.text = s.dusun;
      _desa.text = s.desa;
      _kecamatan.text = s.kecamatan;
      _kabupaten.text = s.kabupaten;
      _provinsi.text = s.provinsi;
      _kodePos.text = s.kodePos;
      _namaAyah.text = s.namaAyah;
      _namaIbu.text = s.namaIbu;
      _namaWali.text = s.namaWali ?? '';
      _alamatOrtu.text = s.alamatOrangTua;
    }
  }

  @override
  void dispose() {
    _nisn.dispose();
    _namaLengkap.dispose();
    _agama.dispose();
    _tempatLahir.dispose();
    _nomorTlp.dispose();
    _nik.dispose();
    _jalan.dispose();
    _rtRw.dispose();
    _dusun.dispose();
    _desa.dispose();
    _kecamatan.dispose();
    _kabupaten.dispose();
    _provinsi.dispose();
    _kodePos.dispose();
    _namaAyah.dispose();
    _namaIbu.dispose();
    _namaWali.dispose();
    _alamatOrtu.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir wajib diisi')),
      );
      return;
    }
    final student = Student(
      id: widget.student?.id,
      nisn: _nisn.text.trim(),
      namaLengkap: _namaLengkap.text.trim(),
      jenisKelamin: _jenisKelamin,
      agama: _agama.text.trim(),
      tempatLahir: _tempatLahir.text.trim(),
      tanggalLahir: _tanggalLahir!,
      nomorTlp: _nomorTlp.text.trim(),
      nik: _nik.text.trim(),
      jalan: _jalan.text.trim(),
      rtRw: _rtRw.text.trim(),
      dusun: _dusun.text.trim(),
      desa: _desa.text.trim(),
      kecamatan: _kecamatan.text.trim(),
      kabupaten: _kabupaten.text.trim(),
      provinsi: _provinsi.text.trim(),
      kodePos: _kodePos.text.trim(),
      namaAyah: _namaAyah.text.trim(),
      namaIbu: _namaIbu.text.trim(),
      namaWali: _namaWali.text.trim().isEmpty ? null : _namaWali.text.trim(),
      alamatOrangTua: _alamatOrtu.text.trim(),
    );

    setState(() => _submitting = true);
    try {
      if (widget.student == null) {
        await StudentsService.create(student);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Berhasil menambah data')));
      } else {
        await StudentsService.update(widget.student!.id!, student);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil menyimpan perubahan')),
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial =
        _tanggalLahir ?? DateTime(now.year - 15, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1980),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => _tanggalLahir = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Ubah Siswa' : 'Tambah Siswa')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Identitas'),
              _text('NISN', _nisn, validator: _required),
              _text('Nama Lengkap', _namaLengkap, validator: _required),
              _dropdownJenisKelamin(),
              _text('Agama', _agama, validator: _required),
              _text('Tempat Lahir', _tempatLahir, validator: _required),
              _dateField('Tanggal Lahir'),
              _text('Nomor Tlp/HP', _nomorTlp, validator: _required),
              _text('NIK', _nik, validator: _required),

              _sectionTitle('Alamat'),
              _text('Jalan', _jalan, validator: _required),
              _text('RT/RW', _rtRw, validator: _required),
              _text('Dusun', _dusun, validator: _required),
              _text('Desa', _desa, validator: _required),
              _text('Kecamatan', _kecamatan, validator: _required),
              _text('Kabupaten', _kabupaten, validator: _required),
              _text('Provinsi', _provinsi, validator: _required),
              _text('Kode Pos', _kodePos, validator: _required),

              _sectionTitle('Orang Tua/Wali'),
              _text('Nama Ayah', _namaAyah, validator: _required),
              _text('Nama Ibu', _namaIbu, validator: _required),
              _text('Nama Wali (opsional)', _namaWali),
              _text(
                'Alamat Orang Tua/Wali',
                _alamatOrtu,
                validator: _required,
                maxLines: 3,
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  Widget _text(
    String label,
    TextEditingController c, {
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dateField(String label) {
    final text = _tanggalLahir == null
        ? ''
        : _tanggalLahir!.toLocal().toIso8601String().split('T').first;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: _pickDate,
        child: InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tanggal Lahir',
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text.isEmpty ? 'Pilih tanggal' : text),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownJenisKelamin() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: _jenisKelamin,
        items: const [
          DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
          DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
        ],
        onChanged: (v) => setState(() => _jenisKelamin = v ?? 'Laki-laki'),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Jenis Kelamin',
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
