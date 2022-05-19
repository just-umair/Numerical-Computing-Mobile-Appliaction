import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewtonRaphason extends StatefulWidget {
  const NewtonRaphason({Key? key}) : super(key: key);

  @override
  State<NewtonRaphason> createState() => _NewtonRaphasonState();
}

class _NewtonRaphasonState extends State<NewtonRaphason> {
  var newtonRaphasonData;

  bool flag = false;
  String url = '';
  late Map listofdata;
  var data;
  var b_data, c_data;
  var equation = '';
  var firstRoot = '';
  int loop = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Newton Raphason Method')),
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
              TextButton(
                onPressed: () async {
                  String url =
                      "http://10.0.2.2:5000/newtonRaphason?equation=$equation&firstRoot=$firstRoot";
                  final response = await http.get(Uri.parse(url));
                  if (kDebugMode) {
                    //print(response.body);
                  }

                  setState(() {
                    flag = true;
                    newtonRaphasonData = jsonDecode(response.body);
                    print(newtonRaphasonData['a'].runtimeType);

                    data = newtonRaphasonData['a'];
                    b_data = newtonRaphasonData['b'];
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
