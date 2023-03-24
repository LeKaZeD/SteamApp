import 'package:flutter/material.dart';
import 'package:steam_app/UI/MyApp/view/MyApp.dart';
import 'package:steam_app/data/api/DatabaseServices.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*void main() {
  runApp(const MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: DatabaseServices.DatabaseUrl, anonKey: DatabaseServices.Apikey);
  runApp(MyApp());
}
