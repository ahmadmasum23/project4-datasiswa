import 'package:flutter/material.dart';
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

  Future<void> _delete(String id) async {
    try {
      await StudentsService.deleteById(id);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Berhasil menghapus data')));
      _reload();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
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
                        icon: const Icon(Icons.delete),
                        onPressed: () => _delete(s.id!),
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
