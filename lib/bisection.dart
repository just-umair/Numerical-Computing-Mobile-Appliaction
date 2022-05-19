import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bisection extends StatefulWidget {
  const Bisection({Key? key}) : super(key: key);

  @override
  State<Bisection> createState() => _BisectionState();
}

class _BisectionState extends State<Bisection> {
  var bisectionData;

  bool flag = false;
  String url = '';
  late Map listofdata;
  var data;
  var b_data, c_data;
  var equation = '';
  var firstRoot = '';
  var secondRoot = '';
  int loop = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bisection Method')),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  equation = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  firstRoot = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  secondRoot = value;
                },
              ),
              TextButton(
                onPressed: () async {
                  String url =
                      "http://10.0.2.2:5000/bisection?equation=$equation&firstRoot=$firstRoot&secondRoot=$secondRoot";
                  final response = await http.get(Uri.parse(url));
                  if (kDebugMode) {
                    //print(response.body);
                  }

                  setState(() {
                    flag = true;
                    bisectionData = jsonDecode(response.body);
                    print(bisectionData['a'].runtimeType);

                    data = bisectionData['a'];
                    b_data = bisectionData['b'];
                    c_data = bisectionData['c'];
                  });
                },
                child: const Text(
                  'Solve',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: flag == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('a'),
                              Text('b'),
                              Text('c'),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(data[index]),
                                    Text(b_data[index]),
                                    Text(c_data[index]),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Text('No data added'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
