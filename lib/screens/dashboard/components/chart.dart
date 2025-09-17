import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../services/students_service.dart';
import '../../../models/student.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = StudentsService.fetchAll();
  }

  List<PieChartSectionData> _buildSections(int male, int female) {
    final int total = male + female == 0 ? 1 : male + female;
    final double malePct = male / total * 100.0;
    final double femalePct = female / total * 100.0;
    return [
      PieChartSectionData(
        color: primaryColor,
        value: malePct,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: const Color(0xFFFFA113),
        value: femalePct,
        showTitle: false,
        radius: 22,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: 200,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        final data = snapshot.data ?? [];
        final male = data.where((s) => s.jenisKelamin == 'Laki-laki').length;
        final female = data.where((s) => s.jenisKelamin == 'Perempuan').length;
        final total = data.length;
        return SizedBox(
          height: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: _buildSections(male, female),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: defaultPadding),
                    Text(
                      '$total',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                    ),
                    const Text('Total Siswa'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
