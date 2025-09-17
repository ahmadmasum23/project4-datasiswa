import 'package:flutter/material.dart';
import 'package:project4/constants.dart';
import 'package:project4/models/student.dart';
import 'package:project4/services/students_service.dart';

class RecentStudents extends StatefulWidget {
  const RecentStudents({super.key});

  @override
  State<RecentStudents> createState() => _RecentStudentsState();
}

class _RecentStudentsState extends State<RecentStudents> {
  late Future<List<Student>> _future;
  int _page = 0;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _future = StudentsService.fetchAll();
    StudentsService.refreshSignal.addListener(() {
      if (mounted) {
        setState(() {
          _future = StudentsService.fetchAll();
          _page = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Students',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Nama Siswa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "NISN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Jenis Kelamin",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // ===== DATA SISWA =====
            FutureBuilder<List<Student>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final all = snapshot.data ?? [];
                if (all.isEmpty) {
                  return const Text('Belum ada data');
                }
                final start = _page * _pageSize;
                final end = (start + _pageSize) > all.length
                    ? all.length
                    : start + _pageSize;
                final items = all.sublist(start, end);

                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, i) {
                        final s = items[i];

                        return Row(
                          children: [
                            // Avatar + Nama
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.primaries[i %
                                              Colors.primaries.length],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.insert_drive_file,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      s.namaLengkap,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // NISN
                            Expanded(
                              flex: 2,
                              child: Text(
                                s.nisn,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Jenis Kelamin
                            Expanded(
                              flex: 2,
                              child: Text(
                                s.jenisKelamin,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Menampilkan ${start + 1}-${end} dari ${all.length} siswa',
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: _page > 0
                                  ? () => setState(() => _page -= 1)
                                  : null,
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: end < all.length
                                  ? () => setState(() => _page += 1)
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
