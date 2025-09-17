import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://wqmtszixilwleqcyqnao.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndxbXRzeml4aWx3bGVxY3lxbmFvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwMTgxNzEsImV4cCI6MjA3MzU5NDE3MX0.Rtc81ZYAs_hc7wl45Yn59rjUs5gWqcG8FhsGUbooseU';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}

