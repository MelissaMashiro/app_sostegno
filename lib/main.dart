import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';
import 'package:app_sostegno/routes/getx_pages_generator.dart';
import 'package:app_sostegno/routes/routes_name.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthenticationBloc>(),
        ),
      ],
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', ''),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Sostegno',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: kMainPurpleColor),
          //primaryColor: kMainPurpleColor,
          // iconTheme: const IconThemeData(color: kMainPinkColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RoutesName.LOADING_PAGE,
        getPages: getPagesList,
      ),
    );
  }
}
