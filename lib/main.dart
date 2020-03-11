import 'package:dynamictheme/theme_changer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: DynamicThemeScreen(),
    );
  }
}

class DynamicThemeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeChanger>(context).getTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, themeChanger, child) {
        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Dynamic Theme'),
            actions: <Widget>[
//              CupertinoSwitch(
//                  value: themeChanger.getValue(), onChanged: (newValue) => themeChanger.setValue(newValue),)
//              Switch(
//                  value: themeChanger.getValue(),
//                  onChanged: (newValue) => themeChanger.setValue(newValue)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: 40.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: themeChanger
                              .getValue() //This value is getting from theme_changer class
                          ? Colors.black45
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Stack(
                    children: <Widget>[
                      Center(child: Text(themeChanger.getMode())),
                      AnimatedPositioned(
                        child: InkWell(
                          onTap: () {
                            themeChanger.setValue();
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                turns: animation,
                                child: child,
                              );
                            },
                            child: themeChanger.getValue()
                                ? Icon(
                                    Icons.brightness_2,
                                    size: 35.0,
                                    color: Colors.green,
                                    key: UniqueKey(),
                                  )
                                : Icon(
                                    Icons.wb_sunny,
                                    size: 35.0,
                                    color: Colors.white,
                                    key: UniqueKey(),
                                  ),
                          ),
                        ),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        left: themeChanger.getValue() ? 80.0 : 0.0,
                        //This value is getting from theme_changer class
                        right: themeChanger.getValue() ? 0.0 : 80.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                      color: Theme.of(context).backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Switch to Light Theme',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        // themeChanger.setTheme(ThemeData.light());
                      }),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: MaterialButton(
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Switch to Dark Theme',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      onPressed: () {
                        //  themeChanger.setTheme(ThemeData.dark());
                      }),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
