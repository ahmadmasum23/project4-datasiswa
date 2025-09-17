import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // untuk haptic feedback
import 'package:project4/constants.dart';
import 'package:project4/models/student.dart';
import 'package:project4/screens/students/students_form_screen.dart';
import 'package:project4/services/students_service.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = StudentsService.fetchAll();
    StudentsService.refreshSignal.addListener(() {
      if (mounted) {
        _reload();
      }
    });
  }

  Future<void> _reload() async {
    setState(() {
      _future = StudentsService.fetchAll();
    });
  }

  void _openForm({Student? student}) async {
    final changed = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => StudentsFormScreen(student: student)),
    );
    if (changed == true) {
      _reload();
    }
  }

  /// Hapus data + popup notifikasi
  Future<void> _delete(String id) async {
    HapticFeedback.mediumImpact();

    // tampilkan dialog loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(strokeWidth: 2),
              SizedBox(width: 16),
              Text("Menghapus data..."),
            ],
          ),
        ),
      ),
    );

    try {
      await StudentsService.deleteById(id);
      if (!mounted) return;

      Navigator.pop(context); // tutup loading

      // popup berhasil
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Berhasil"),
            ],
          ),
          content: const Text("Data siswa berhasil dihapus."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("OK", style: TextStyle(color: primaryColor)),
            ),
          ],
        ),
      );

      _reload();
    } catch (e) {
      if (!mounted) return;

      Navigator.pop(context); // tutup loading

      // popup gagal
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent),
              SizedBox(width: 8),
              Text("Gagal"),
            ],
          ),
          content: Text("Gagal menghapus data:\n$e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Tutup"),
            ),
          ],
        ),
      );
    }
  }

  /// Dialog konfirmasi hapus
  void _showDeleteDialog(BuildContext context, Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12),
              const Text(
                'Hapus Data?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Data siswa ini akan dihapus permanen.\nApakah Anda yakin?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(ctx, true);
                        await _delete(student.id!);
                      },
                      child: const Text(
                        "Hapus",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true) {
      // sudah ditangani di tombol Hapus
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Siswa'),
        backgroundColor: secondaryColor,
        actions: [
          IconButton(onPressed: _reload, icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Student>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final students = snapshot.data ?? [];
          if (students.isEmpty) {
            return const Center(child: Text('Belum ada data'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(defaultPadding),
            itemCount: students.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final s = students[index];
              return Card(
                child: ListTile(
                  title: Text('${s.namaLengkap} — ${s.nisn}'),
                  subtitle: Text(
                    '${s.jenisKelamin} • ${s.agama}\n${s.tempatLahir}, ${s.tanggalLahir.toLocal().toIso8601String().split('T').first}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openForm(student: s),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _showDeleteDialog(context, s),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
