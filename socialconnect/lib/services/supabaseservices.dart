import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  static final SupabaseClient client = Supabase.instance.client;
  static Rx<User?> currentUser = Rx<User?>(null);

  @override
  Future<void> onInit() async {

     await Supabase.initialize(
    url: "https://massqohrwvyezbghqhho.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1hc3Nxb2hyd3Z5ZXpiZ2hxaGhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM0NDI3NzMsImV4cCI6MjA2OTAxODc3M30.dVervRA-eXd6jmEwUco_uuq4rSsM3iJ2-YiQWE0ZK6Y",
  );
    listenOnAuthChange();
    super.onInit();
  }

  void listenOnAuthChange() {
    client.auth.onAuthStateChange.listen((event) {
      final AuthChangeEvent authChangeEvent = event.event;
      if (authChangeEvent == AuthChangeEvent.userUpdated) {
        currentUser.value = event.session?.user;
      } else if (authChangeEvent == AuthChangeEvent.signedIn) {
        currentUser.value = event.session?.user;
        
      }
    });
  }

 
}
