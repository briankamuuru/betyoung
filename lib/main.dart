import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer_item.dart';
import 'firebase_options.dart';
import 'logic/payments.dart';
import 'widgets/free_item.dart';
import 'widgets/vip_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseApi.init();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

//background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'Ubuntu',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        centerTitle: true,
        title: const Text(
          'WELCOME TO BETYOUNG',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 51, 4),
        elevation: 0,
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 13, 51, 4),
          child: Column(
            children: [
              drawerItem(
                name: "Privacy Policy",
                myIcon: Icons.policy,
                link:
                    "https://www.freeprivacypolicy.com/live/d167cce1-522f-4ac9-b7bb-9005a3f8a7e7",
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: const DecorationImage(
            image: const AssetImage("assets/logo1024.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // crossAxisCount: 2,
                  crossAxisCount: 1,

                  childAspectRatio: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: const [
                  HomeItem(
                    itemName: "DAILY FREE TIPS",
                    type: "free",
                  ),
                  VipItem(
                    itemName: "2 ODDS VIP",
                    type: '2o',
                    weeklyPrice: "20",
                    monthlyPrice: "30",
                  ),
                  VipItem(
                    itemName: "DRAWS FIXED VIP",
                    type: '4o',
                    weeklyPrice: "10",
                    monthlyPrice: "20",
                  ),
                  VipItem(
                    itemName: "HT/FT FIXED VIP",
                    type: '10o',
                    weeklyPrice: "12",
                    monthlyPrice: "25",
                  ),
                  VipItem(
                    itemName: "CORRECT SCORE VIP",
                    type: '50o',
                    weeklyPrice: "40",
                    monthlyPrice: "60",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Color.fromARGB(255, 55, 207, 9),
      //   extendedPadding: const EdgeInsets.symmetric(
      //     horizontal: 50,
      //     vertical: 20,
      //   ),
      //   icon: const Icon(
      //     Icons.telegram,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     _launchInBrowser("https://t.me/oddlab22");
      //   },
      //   label: const Text(
      //     "Join Telegram",
      //     style: TextStyle(fontSize: 24, color: Colors.white),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //link launcher
  Future<void> _launchInBrowser(linkName) async {
    final uri = Uri.parse(linkName);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      throw 'Could not launch $linkName';
    }
  }
}
