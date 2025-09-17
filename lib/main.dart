import 'package:project4/constants.dart';
import 'package:project4/controllers/menu_app_controller.dart';
import 'package:project4/screens/main/main_screen.dart';
import 'package:project4/config/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuAppController()),
        ],
        child: ConnectivityGate(child: MainScreen()),
      ),
    );
  }
}

class ConnectivityGate extends StatefulWidget {
  final Widget child;
  const ConnectivityGate({super.key, required this.child});

  @override
  State<ConnectivityGate> createState() => _ConnectivityGateState();
}

class _ConnectivityGateState extends State<ConnectivityGate> {
  late final Connectivity _connectivity;
  bool _offline = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkOnce();
    _connectivity.onConnectivityChanged.listen((status) {
      final isOffline = status == ConnectivityResult.none;
      if (isOffline != _offline) {
        setState(() => _offline = isOffline);
        if (isOffline) {
          _showOfflineDialog();
        }
      }
    });
  }

  Future<void> _checkOnce() async {
    final status = await _connectivity.checkConnectivity();
    final isOffline = status == ConnectivityResult.none;
    if (mounted && isOffline) {
      setState(() => _offline = true);
      _showOfflineDialog();
    }
  }

  void _showOfflineDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Koneksi Terputus'),
        content: const Text(
          'Pastikan perangkat Anda terhubung ke internet untuk melanjutkan.\nWi‑Fi atau data seluler sedang tidak aktif.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
