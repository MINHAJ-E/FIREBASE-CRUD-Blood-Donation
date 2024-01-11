import 'package:blood_donation/controller/dropdown_provider.dart';
import 'package:blood_donation/controller/edit_add_delete_provider.dart';
import 'package:blood_donation/controller/home_provider.dart';
import 'package:blood_donation/controller/image_provider.dart';
import 'package:blood_donation/services/firebase_options.dart';
import 'package:blood_donation/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {  
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DropdownProvider(),),
        ChangeNotifierProvider(create: (context) => ImageProviderr(),),
        ChangeNotifierProvider(create: (context) => AddDeleteProvider(),),
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
