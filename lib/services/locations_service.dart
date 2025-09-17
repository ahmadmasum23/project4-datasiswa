import 'package:project4/config/supabase_config.dart';
import 'package:project4/models/location.dart';

class LocationsService {
  static const String table = 'locations';

  static Future<List<LocationEntry>> searchDusun(String query) async {
    if (query.trim().isEmpty) return [];
    final resp = await SupabaseConfig.client
        .from(table)
        .select()
        .ilike('dusun', '%${query.trim()}%')
        .limit(20);
    final List list = resp as List;
    return list.map((e) => LocationEntry.fromJson(e)).toList();
  }

  static Future<LocationEntry?> getByDusunExact(String dusun) async {
    final resp = await SupabaseConfig.client
        .from(table)
        .select()
        .eq('dusun', dusun)
        .limit(1)
        .maybeSingle();
    if (resp == null) return null;
    return LocationEntry.fromJson(resp);
  }
}
