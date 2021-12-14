import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // * The onboarding screen (first screen)
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Get yourself a Snackbar !'),
          ),
          body: Builder(
              builder: (context) => Center(
                      child: Column(children: [
                    const Text('What\'s your @sign ?'),
                    TextField(
                      controller: myController,
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    currentAtsign: myController.text),
                              )
                            );
                        });
                      },
                      child: const Text('get ready for snacks!'),
                    )
                  ]
            )
          )
        )
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentAtsign;
  const HomeScreen({Key? key, required this.currentAtsign}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Snack lastsnack = Snack(snack: 'hungry');

  late Timer timer;
@override
  void initState() {
    super.initState();
    checkApi();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => checkApi());
  }

  @override
  Widget build(BuildContext context) {
    String? currentAtsign = widget.currentAtsign;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar receiver'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Waiting for snacks !'),
            Text('Current @sign: $currentAtsign'),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void checkApi() {
    setState(() {
      checkForSnacks(context, widget.currentAtsign, lastsnack);
    });
  }
}

Future<void> checkForSnacks(context, String atsign, Snack lastsnack) async {
  String mysnack = await getAtsignData(atsign);
  if (mysnack != lastsnack.snack) {
    popSnackBar(context, mysnack);
  }
  lastsnack.snack = mysnack;
}

Future<String> getAtsignData(String atsign) async {
  String lookup = 'https://wavi.ng/api?atp=snackbar.fourballcorporate9$atsign';
  http.Response result = await http.get(Uri.parse(lookup));
  var snackMap = jsonDecode(result.body);
  // Known key 'snackbar' known NAMESPACE 'fourballcorporate9`
  var snackJson = jsonDecode(snackMap[0]['snackbar.fourballcorporate9']);
  var snack = Snack.fromJson(snackJson);
  return ((snack.snack.toString()));
}

void popSnackBar(context, String snack) {
  final snackBar = SnackBar(
    content: Text('Yay! A$snack ! '),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class Snack {
  String snack;

  Snack({
    required this.snack,
  });

  Snack.fromJson(Map<String, dynamic> json) : snack = json['snack'];

  Map<String, dynamic> toJson() => {
        '"snack"': '"$snack"',
      };
}
