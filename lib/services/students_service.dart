import 'package:flutter/foundation.dart';
import 'package:project4/config/supabase_config.dart';
import 'package:project4/models/student.dart';

class StudentsService {
  static const String table = 'students';
  static final ValueNotifier<int> refreshSignal = ValueNotifier<int>(0);

  static Future<List<Student>> fetchAll() async {
    final response = await SupabaseConfig.client
        .from(table)
        .select()
        .order('created_at', ascending: false);
    final List data = response as List;
    return data
        .map((e) => Student.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<Student> create(Student student) async {
    final insertMap = student.toJson();
    insertMap.remove('id');
    insertMap.remove('created_at');
    insertMap.remove('updated_at');
    insertMap.remove('created_by');
    final response = await SupabaseConfig.client
        .from(table)
        .insert(insertMap)
        .select()
        .single();
    final created = Student.fromJson(response);
    refreshSignal.value++;
    return created;
  }

  static Future<Student> update(String id, Student student) async {
    final updateMap = student.toJson();
    updateMap.remove('id');
    updateMap.remove('created_at');
    updateMap.remove('updated_at');
    updateMap.remove('created_by');
    final response = await SupabaseConfig.client
        .from(table)
        .update(updateMap)
        .eq('id', id)
        .select()
        .single();
    final updated = Student.fromJson(response);
    refreshSignal.value++;
    return updated;
  }

  static Future<void> deleteById(String id) async {
    await SupabaseConfig.client.from(table).delete().eq('id', id);
    refreshSignal.value++;
  }
}
