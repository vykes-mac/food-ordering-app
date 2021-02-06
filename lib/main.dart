import 'package:flutter/material.dart';
import 'package:food_ordering_app/composition_root.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  final screenToShow = await CompositionRoot.start();
  runApp(MyApp(screenToShow));
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  MyApp(this.startPage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Space',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color.fromARGB(255, 251, 176, 59),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: startPage,
    );
  }
}
