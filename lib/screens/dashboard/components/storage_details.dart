import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';
import '../../../services/students_service.dart';
import '../../../models/student.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key}) : super(key: key);

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = StudentsService.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Agama",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          FutureBuilder<List<Student>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final data = snapshot.data ?? [];
              final Map<String, int> agamaCount = {};
              for (final student in data) {
                agamaCount[student.agama] =
                    (agamaCount[student.agama] ?? 0) + 1;
              }
              final agamaList = agamaCount.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));

              return Column(
                children: agamaList.take(4).map((entry) {
                  final agama = entry.key;
                  final count = entry.value;
                  return StorageInfoCard(
                    svgSrc: "assets/icons/Documents.svg",
                    title: agama,
                    amountOfFiles: "$count",
                    numOfFiles: count,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
