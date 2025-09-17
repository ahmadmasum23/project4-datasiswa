import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfPerson, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfPerson,
    this.percentage,
    this.color,
  });
}

// Demo data removed - now using dynamic data from StudentsService
