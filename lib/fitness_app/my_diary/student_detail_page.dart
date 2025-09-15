import 'package:flutter/material.dart';
import 'package:project4/fitness_app/fitness_app_theme.dart';
import 'package:project4/fitness_app/models/student_data.dart';
import 'package:project4/main.dart';

class StudentDetailPage extends StatelessWidget {
  final StudentData studentData;

  const StudentDetailPage({Key? key, required this.studentData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      appBar: AppBar(
        backgroundColor: HexColor(studentData.endColor),
        elevation: 0,
        title: Text(
          'Detail Siswa',
          style: TextStyle(
            color: FitnessAppTheme.white,
            fontFamily: FitnessAppTheme.fontName,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: FitnessAppTheme.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <HexColor>[
                    HexColor(studentData.startColor),
                    HexColor(studentData.endColor),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: HexColor(studentData.endColor).withOpacity(0.3),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: FitnessAppTheme.white.withOpacity(0.2),
                      child: Image.asset(
                        studentData.imagePath,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      studentData.namaLengkap,
                      style: TextStyle(
                        color: FitnessAppTheme.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: FitnessAppTheme.fontName,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'NISN: ${studentData.nisn}',
                      style: TextStyle(
                        color: FitnessAppTheme.white.withOpacity(0.9),
                        fontSize: 16,
                        fontFamily: FitnessAppTheme.fontName,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Data Pribadi
            _buildSectionCard('Data Pribadi', [
              _buildInfoRow('NISN', studentData.nisn),
              _buildInfoRow('Nama Lengkap', studentData.namaLengkap),
              _buildInfoRow('Jenis Kelamin', studentData.jenisKelamin),
              _buildInfoRow('Agama', studentData.agama),
              _buildInfoRow(
                'Tempat, Tanggal Lahir',
                '${studentData.tempatLahir}, ${studentData.tanggalLahir}',
              ),
              _buildInfoRow('Nomor Tlp/HP', studentData.nomorTlp),
              _buildInfoRow('NIK', studentData.nik),
            ]),

            SizedBox(height: 16),

            // Data Alamat
            _buildSectionCard('Alamat', [
              _buildInfoRow('Jalan', studentData.alamat.jalan),
              _buildInfoRow('RT/RW', studentData.alamat.rtRw),
              _buildInfoRow('Dusun', studentData.alamat.dusun),
              _buildInfoRow('Desa', studentData.alamat.desa),
              _buildInfoRow('Kecamatan', studentData.alamat.kecamatan),
              _buildInfoRow('Kabupaten', studentData.alamat.kabupaten),
              _buildInfoRow('Provinsi', studentData.alamat.provinsi),
              _buildInfoRow('Kode Pos', studentData.alamat.kodePos),
            ]),

            SizedBox(height: 16),

            // Data Orang Tua/Wali
            _buildSectionCard('Orang Tua/Wali', [
              _buildInfoRow('Nama Ayah', studentData.orangTua.namaAyah),
              _buildInfoRow('Nama Ibu', studentData.orangTua.namaIbu),
              if (studentData.orangTua.namaWali.isNotEmpty)
                _buildInfoRow('Nama Wali', studentData.orangTua.namaWali),
              _buildInfoRow('Alamat', studentData.orangTua.alamat),
            ]),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FitnessAppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: FitnessAppTheme.nearlyBlack.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HexColor(studentData.endColor),
                fontFamily: FitnessAppTheme.fontName,
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: FitnessAppTheme.nearlyBlack,
                fontFamily: FitnessAppTheme.fontName,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: FitnessAppTheme.nearlyBlack,
                fontFamily: FitnessAppTheme.fontName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
