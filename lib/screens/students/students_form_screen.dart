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
  final _identitasFormKey = GlobalKey<FormState>();
  final _alamatFormKey = GlobalKey<FormState>();
  final _orangTuaFormKey = GlobalKey<FormState>();
  bool _submitting = false;
  int _currentStep = 0;

  final TextEditingController _nisn = TextEditingController();
  final TextEditingController _namaLengkap = TextEditingController();
  String _jenisKelamin = 'Laki-laki';
  String _agama = 'Islam';
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
      _agama = s.agama;
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
    // Validate all forms before submission
    if (!_identitasFormKey.currentState!.validate() ||
        !_alamatFormKey.currentState!.validate() ||
        !_orangTuaFormKey.currentState!.validate()) {
      return;
    }
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
      agama: _agama,
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil menambah data')),
        );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
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
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            // Validate Identitas step
            if (_identitasFormKey.currentState!.validate() && _tanggalLahir != null) {
              setState(() => _currentStep += 1);
            } else if (_tanggalLahir == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tanggal lahir wajib diisi')),
              );
            }
          } else if (_currentStep == 1) {
            // Validate Alamat step
            if (_alamatFormKey.currentState!.validate()) {
              setState(() => _currentStep += 1);
            }
          } else if (_currentStep == 2) {
            // Submit on final step
            if (_orangTuaFormKey.currentState!.validate()) {
              _submit();
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Navigator.of(context).pop();
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                if (_currentStep < 2)
                  ElevatedButton(
                    onPressed: _submitting ? null : details.onStepContinue,
                    child: _submitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Lanjut'),
                  )
                else
                  ElevatedButton(
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
                  ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Batal'),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Identitas'),
            content: Form(
              key: _identitasFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text('NISN', _nisn, validator: _required),
                  _text('Nama Lengkap', _namaLengkap, validator: _required),
                  _dropdownJenisKelamin(),
                  _dropdownAgama(),
                  _text('Tempat Lahir', _tempatLahir, validator: _required),
                  _dateField('Tanggal Lahir'),
                  _text('Nomor Tlp/HP', _nomorTlp, validator: _phoneValidator),
                  _text('NIK', _nik, validator: _nikValidator),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Alamat'),
            content: Form(
              key: _alamatFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text('Jalan', _jalan, validator: _required),
                  _text('RT/RW', _rtRw, validator: _rtRwValidator),
                  _text('Dusun', _dusun, validator: _required),
                  _text('Desa', _desa, validator: _required),
                  _text('Kecamatan', _kecamatan, validator: _required),
                  _text('Kabupaten', _kabupaten, validator: _required),
                  _text('Provinsi', _provinsi, validator: _required),
                  _text('Kode Pos', _kodePos, validator: _required),
                ],
              ),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Orang Tua/Wali'),
            content: Form(
              key: _orangTuaFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text('Nama Ayah', _namaAyah, validator: _required),
                  _text('Nama Ibu', _namaIbu, validator: _required),
                  _text('Nama Wali (opsional)', _namaWali),
                  _text(
                    'Alamat Orang Tua/Wali',
                    _alamatOrtu,
                    validator: _required,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 2,
            state: StepState.indexed,
          ),
        ],
      ),
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  String? _phoneValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    if (!RegExp(r'^\d+$').hasMatch(v.trim())) return 'Hanya angka yang diperbolehkan';
    return null;
  }

  String? _nikValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    if (!RegExp(r'^\d+$').hasMatch(v.trim())) return 'Hanya angka yang diperbolehkan';
    return null;
  }

  String? _rtRwValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    if (!RegExp(r'^\d+/\d+$').hasMatch(v.trim())) return 'Format RT/RW harus angka/angka';
    return null;
  }

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

  Widget _dropdownAgama() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: _agama,
        items: const [
          DropdownMenuItem(value: 'Islam', child: Text('Islam')),
          DropdownMenuItem(value: 'Kristen Protestan', child: Text('Kristen Protestan')),
          DropdownMenuItem(value: 'Katolik', child: Text('Katolik')),
          DropdownMenuItem(value: 'Hindu', child: Text('Hindu')),
          DropdownMenuItem(value: 'Buddha', child: Text('Buddha')),
          DropdownMenuItem(value: 'Konghucu', child: Text('Konghucu')),
        ],
        onChanged: (v) => setState(() => _agama = v ?? 'Islam'),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Agama',
        ),
        validator: _required,
      ),
    );
  }
}