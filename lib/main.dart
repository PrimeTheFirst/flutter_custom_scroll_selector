import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:ScrollSelector()
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class ScrollSelector extends StatefulWidget {
  const ScrollSelector({super.key});

  @override
  State<ScrollSelector> createState() => _ScrollSelectorState();
}

class _ScrollSelectorState extends State<ScrollSelector> {
  List<int> years = List<int>.generate(2030, (i) => i+2023); // set the first value as the max and i+x , x = start value
  List<int> months = List<int>.generate(12, (i) => i+1); // set the first value as the max and i+x , x = start value
  int month = 0;
  int year = 0;
  List<int> month_with_thirtyone_days = [1,3,5,7,8,10,12];
  final PageController _pageController = PageController();
  List<Widget> dayWidgets = List<int>.generate(31, (i) => i+1)
      .map((e) => Center(
      child: Text(
          (e.toString().length == 1) ? '0$e' : e.toString())))
      .toList();
  @override
  void initState() {
    year = years[0];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        ConstrainedBox( //copy and paste more of these ConstrainedBox's if you need more sliders
          constraints: const BoxConstraints(maxWidth: 50, minWidth: 20),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            height: 70,
            child: PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (int page) {
                setState(() { // set variable value here e.g year = year_list[page];
                  year = years[page];
                });
              },
              children: years
                  .map((e) => Center(
                  child: Text(
                      (e.toString().length == 1) ? '0$e' : e.toString())))
                  .toList(),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 50, minWidth: 20),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            height: 70,
            child: PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (int page) {
                setState(() {
                  month = months[page];
                });
              },
              children: months
                  .map((e) => Center(
                  child: Text(
                      (e.toString().length == 1) ? '0$e' : e.toString())))
                  .toList(),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 50, minWidth: 20),
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            height: 70,
            child: PageView(
              onPageChanged: (int page) {
                setState(() {

                });
              },
              scrollDirection: Axis.vertical,
              children: getDayWidgetsForMonth(month,year,dayWidgets,month_with_thirtyone_days)
            ),
          ),
        ),
      ],
    );

  }
}

List<Widget> getDayWidgetsForMonth(int month, int year, List<Widget> dayWidgets, List<int> monthWithThirtyOneDays) {
  if (monthWithThirtyOneDays.contains(month)) {
    return dayWidgets;
  } else if (month == 2) {
    if (year % 4 == 0) {
      // Leap year
      return dayWidgets.sublist(0, dayWidgets.length - 2); // February in leap year has 29 days
    } else {
      return dayWidgets.sublist(0, dayWidgets.length - 3); // February in non-leap year has 28 days
    }
  } else {
    return dayWidgets.sublist(0, dayWidgets.length - 1); // Months with 30 days
  }
}
