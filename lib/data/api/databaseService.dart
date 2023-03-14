import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient client;

  DatabaseService(this.client);

  void createUser(AuthResponse res) async {
    await client.from('user').insert({
      'username': res.session?.user.email,
      'like': [],
      'wish': [],
      'User': res.session?.user.id
    });
  }
}
