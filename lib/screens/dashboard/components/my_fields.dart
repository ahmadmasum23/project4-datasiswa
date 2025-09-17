import 'package:project4/models/my_files.dart';
import 'package:project4/responsive.dart';
import 'package:flutter/material.dart';
import 'package:project4/services/students_service.dart';
import 'package:project4/models/student.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Data Siswa", style: Theme.of(context).textTheme.titleMedium),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  late Future<List<Student>> _future;

  @override
  void initState() {
    super.initState();
    _future = StudentsService.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: _future,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        final int male = data
            .where((s) => s.jenisKelamin == 'Laki-laki')
            .length;
        final int female = data
            .where((s) => s.jenisKelamin == 'Perempuan')
            .length;
        final int total = data.length;
        final List<CloudStorageInfo> cards = [
          CloudStorageInfo(
            title: "Laki-Laki",
            numOfPerson: male,
            svgSrc: "assets/icons/Documents.svg",
            totalStorage: "$male",
            color: primaryColor,
            percentage: total == 0 ? 0 : ((male / total) * 100).round(),
          ),
          CloudStorageInfo(
            title: "Perempuan",
            numOfPerson: female,
            svgSrc: "assets/icons/google_drive.svg",
            totalStorage: "$female",
            color: const Color(0xFFFFA113),
            percentage: total == 0 ? 0 : ((female / total) * 100).round(),
          ),
          CloudStorageInfo(
            title: "Jumlah Keseluruhan",
            numOfPerson: total,
            svgSrc: "assets/icons/one_drive.svg",
            totalStorage: "$total",
            color: const Color(0xFFA4CDFF),
            percentage: 100,
          ),
        ];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: widget.childAspectRatio,
          ),
          itemBuilder: (context, index) => FileInfoCard(info: cards[index]),
        );
      },
    );
  }
}
