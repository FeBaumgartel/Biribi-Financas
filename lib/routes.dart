import 'package:biribi_financas/screens/login/login.dart';
import 'package:biribi_financas/screens/principal/principal.dart';
import 'package:flutter/material.dart';
import 'package:biribi_financas/theme.dart' as ThemeApp;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';



class Routes {
  final routes = <String, WidgetBuilder>{
    '/login': (BuildContext context) => Login(),
    '/principal': (BuildContext context) => Principal(),
  };


  Routes() {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {  
          return ThemeNotifier(ThemeApp.Theme.defaultTheme);  
        },
        child: OverlaySupport(
          child: BiribinApp(routes: routes),
        ),
      ),
    );
  }
}

class BiribinApp extends StatelessWidget {

  const BiribinApp({
    Key key,
    @required this.routes,
  }) : super(key: key);

  final Map routes;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return new MaterialApp(
      theme: themeNotifier.getTheme(),
      routes: routes,
      home: new Login(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

}
