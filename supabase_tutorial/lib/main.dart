import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/note_page.dart';


void main() async {
  // supabase setup
  await Supabase.initialize (
    url: 'https://vpofkwpogwmqmvsiicsx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwb2Zrd3BvZ3dtcW12c2lpY3N4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIxMjgwMzMsImV4cCI6MjA4NzcwNDAzM30.E0xRmHTENslG23MqPAtHcjCPZxku8malAWgrmUeA72o',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}
