import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


//String snack = '';
Future<void> main() async {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
            child: ElevatedButton(
              onPressed: () async {
                setState(() {

                });
                
                },
                

            )},
                  nextScreen: const HomeScreen(),
                );
              },
              child: const Text('Onboard an @sign'),
            ),
          ),
        ),
      ),
    );
  }
}

//* The next screen after onboarding (second screen)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /// Get the AtClientManager instance
    String? currentAtsign;




    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar reciever'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                'Successfully onboarded and navigated to FirstAppScreen'),

            /// Use the AtClientManager instance to get the current atsign
            Text('Current @sign: $currentAtsign'),
            const Spacer(flex: 1),

            
          ],
        ),
      ),
    );
  }
}

Future <String> getAtsignData(String atsign) async {
  /// Get the AtClientManager instance

String lookup = 'https://wavi.ng/api?atp=snackbar.fourballcorporate9@$atsign';
  http.Response result = await http.get(Uri.parse(lookup));
  var snackMap = jsonDecode(result.body);
  // Known key 'snackbar' known NAMESPACE 'fourballcorporate9`
  var snackJson = jsonDecode(snackMap[0]['snackbar.fourballcorporate9']);
  var snack = Snack.fromJson(snackJson);
  return(Future.value(snack.toString()));
}


void popSnackBar(context, String snack){
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

  Snack.fromJson(Map<String, dynamic> json)
      : snack = json['snack'];

  Map<String, dynamic> toJson() => {
        'snack': snack,
      };
}
