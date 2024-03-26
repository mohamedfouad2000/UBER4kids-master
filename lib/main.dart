import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Bording/bording.dart';
import 'package:project/Shared/blocobser.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/home/Home.dart';
import 'package:project/login/login.dart';
// import 'package:project/screens/contactus.dart';

Future<void> main() async {
  Uid;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await casheHelber.init();
  Widget w = Home();

  var bordingg = casheHelber.getDataShared(key: 'bording') ?? false;
  Uid = casheHelber.getDataShared(key: 'uId');
//   print(uId);
  if (Uid != null) {
    if (Uid == 'MvRpxoJlDyXeiNG5XsbEH927ce92') {
      w = adminhome();
    } else {
      w = Home();
    }
  } else if (bordingg) {
    w = loginscreen();
  } else {
    w = bording();
  }

  await Firebase.initializeApp();

  runApp(MyApp(
    w: w,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget w;
  MyApp({Key? key, required this.w}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return homeCubit()
              ..getdrivers()
              ..getUserData();
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return admincubit()..getdrivers();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: darkthem,
        home: w,
        theme: lightthem,
      ),
    );
  }
}

ThemeData darkthem = ThemeData(
    // fontFamily: 'Foush',
    brightness: Brightness.dark,
    fontFamily: 'siu',

    // ignore: prefer_const_constructors
    primarySwatch: Colors.teal,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.grey,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.blueGrey[900],
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        titleTextStyle: const TextStyle(
            fontSize: 29, color: Colors.white, fontWeight: FontWeight.bold),
        elevation: 20,
        iconTheme: const IconThemeData(color: Colors.white),
        // ignore: deprecated_member_use
        // backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
          statusBarIconBrightness: Brightness.dark,
        )),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20, color: Colors.white),
      labelSmall: TextStyle(fontSize: 10, color: Colors.white),
    ),
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blueGrey,
      selectedIconTheme: const IconThemeData(color: Colors.black),
    ));
ThemeData lightthem = ThemeData(
  // fontFamily: 'Foush',
  fontFamily: 'siu',
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 20, color: Colors.black),
    displayLarge: TextStyle(fontSize: 15, color: Colors.white),
    labelSmall: TextStyle(fontSize: 10, color: Colors.black),
  ),
  // ignore: prefer_const_constructors
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.teal,
  ),
  scaffoldBackgroundColor: Colors.white,
  // ignore: prefer_const_constructors
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal,
      titleTextStyle: const TextStyle(
          fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      elevation: 0.0,
      // ignore: deprecated_member_use
      // backwardsCompatibility: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      )),
  // ignore: prefer_const_constructors
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.teal,
    selectedIconTheme: const IconThemeData(color: Colors.teal),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
      .copyWith(background: Colors.teal),
);
