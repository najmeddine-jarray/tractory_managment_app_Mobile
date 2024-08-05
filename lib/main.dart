import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tractory/config/theme/app_theme.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/modules/home/Home_bindings.dart';
import 'app/routes/app_pages.dart';
import 'config/translations/localization_service.dart';

void main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();

  // init shared preference
  await MySharedPref.init();

  // init date format language
  await initializeDateFormatting(
      LocalizationService.getCurrentLocal().languageCode);

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: 'Tractor Management App',
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          initialBinding: HomeBindings(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: MySharedPref.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
        );
      },
    ),
  );
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'easy_sidemenu Demo',
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
//       home: const MyHomePage(title: 'easy_sidemenu Demo'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   PageController pageController = PageController();
//   SideMenuController sideMenu = SideMenuController();

//   @override
//   void initState() {
//     sideMenu.addListener((index) {
//       pageController.jumpToPage(index);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text(widget.title),
//         //   centerTitle: true,
//         // ),
//         body: Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SideMenu(
//             controller: sideMenu,
//             style: SideMenuStyle(
//               displayMode: SideMenuDisplayMode.auto,
//               showHamburger: true,
//               hoverColor: Colors.blue[100],
//               selectedHoverColor: Colors.blue[100],
//               selectedColor: Colors.lightBlue,
//               selectedTitleTextStyle: const TextStyle(color: Colors.white),
//               selectedIconColor: Colors.white,
//               backgroundColor:
//                   Colors.grey[200], // Background color for the SideMenu
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//             ),
//             title: Column(
//               children: [
//                 ConstrainedBox(
//                   constraints: const BoxConstraints(
//                     maxHeight: 150,
//                     maxWidth: 150,
//                   ),
//                   // child: Image.asset(
//                   //   'assets/images/easy_sidemenu.png', // Assuming you uncomment the image
//                   // ),
//                 ),
//                 const Divider(
//                   indent: 8.0,
//                   endIndent: 8.0,
//                 ),
//               ],
//             ),
//             footer: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 4, 37, 53),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//                   child: Text(
//                     'mohada',
//                     style: TextStyle(fontSize: 15, color: Colors.grey[800]),
//                   ),
//                 ),
//               ),
//             ),
//             items: [
//               SideMenuItem(
//                 title: 'Dashboard',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.home),
//               ),
//               SideMenuItem(
//                 title: 'Users',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.supervisor_account),
//               ),
//               SideMenuItem(
//                 title: 'Download',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.download),
//               ),
//               SideMenuItem(
//                 builder: (context, displayMode) {
//                   return const Divider(
//                     endIndent: 8,
//                     indent: 8,
//                   );
//                 },
//               ),
//               SideMenuItem(
//                 title: 'Settings',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.settings),
//               ),
//               const SideMenuItem(
//                 title: 'Exit',
//                 icon: Icon(Icons.exit_to_app),
//               ),
//             ],
//           ),
//           const VerticalDivider(
//             width: 0,
//           ),
//           Expanded(
//             child: PageView(
//               controller: pageController,
//               children: [
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Dashboard',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Users',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Expansion Item 1',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Expansion Item 2',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Files',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Download',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 const SizedBox.shrink(),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Settings',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
