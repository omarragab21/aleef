import 'dart:developer';

import 'package:aleef/modules/auth/views/welcome_screens/start_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as materail;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // مسار ملفات الترجمة
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 850.9090909090909),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return Directionality(
          textDirection: context.locale.languageCode == 'ar'
              ? materail.TextDirection.ltr
              : materail.TextDirection.rtl,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
        );
      },
      child: MaterialApp(
        navigatorKey: NavigationService().navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(fontFamily: 'Cairo'),
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}
