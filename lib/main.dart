import 'package:flutter/material.dart';
import 'package:steam_app/UI/MyApp/view/MyApp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*void main() {
  runApp(const MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zlnujbmqmuejpvyuphcf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpsbnVqYm1xbXVlanB2eXVwaGNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg2NjAzMzQsImV4cCI6MTk5NDIzNjMzNH0.Q9UpBnOlMfdPOy7wQ4Ov2YA2aBf6FzgYCOTL3tYtgDk',
  );
  runApp(MyApp());
}
