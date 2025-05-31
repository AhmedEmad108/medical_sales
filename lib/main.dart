import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medical_sales/core/cubit/lang_cubit/lang_cubit.dart';
import 'package:medical_sales/core/cubit/theme_cubit/theme_cubit_cubit.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/helper_functions/on_generate_routs.dart';
import 'package:medical_sales/core/services/custom_bloc_observer.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/services/shared_prefrences_singletone.dart';
import 'package:medical_sales/core/theme/theme.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/features/splash/presentation/views/splash_view.dart';
import 'package:medical_sales/firebase_options.dart';
import 'package:medical_sales/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  String? lang = Prefs.getString('lang');
  await Prefs.setString(
    'lang',
    lang == null || lang == "" || lang.isEmpty
        ? Platform.localeName == 'ar_EG'
            ? 'ar'
            : 'en'
        : lang,
  );
  String? themeMode = Prefs.getString('themeMode');
  await Prefs.setString(
    'themeMode',
    themeMode == null || themeMode == "" || themeMode.isEmpty
        ? 'light'
        : themeMode,
  );
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LangCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => UserCubit(getIt<AuthRepo>())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              final String sharLang = Prefs.getString('lang');
              final String themeMode = Prefs.getString('themeMode');
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(sharLang),
                theme: themeMode == 'light' ? lightTheme : darkTheme,
                title: 'Medical Sales App',
                debugShowCheckedModeBanner: false,
                onGenerateRoute: onGenerateRoute,
                initialRoute: SplashView.routeName,
              );
            },
          );
        },
      ),
    );
  }
}
