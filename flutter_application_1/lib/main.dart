import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo HTTP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lista de Usuários'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> listaUsuarios = [];
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        listaUsuarios = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    print(listaUsuarios.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: listaUsuarios.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: (index % 2 == 0) ? Colors.blue : Colors.green,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text('${listaUsuarios[index]["name"]}',
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${listaUsuarios[index]["username"]}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('${listaUsuarios[index]["email"]}'),
                          Text('${listaUsuarios[index]["phone"]}'),
                          Text('${listaUsuarios[index]["phone"]}'),
                          Text('${listaUsuarios[index]["website"]}'),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Empresa",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0)),
                            Text('${listaUsuarios[index]["company"]["name"]}'),
                            Text(
                                '${listaUsuarios[index]["company"]["catchPhrase"]}'),
                            Text('${listaUsuarios[index]["company"]["bs"]}')
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(
                                255, 0, 0, 0), // Cor do contorno
                            width: 1, // Largura do contorno
                          ),
                          borderRadius: BorderRadius.circular(
                              10), // Arredondamento dos cantos
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Endereço",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                                '${listaUsuarios[index]["address"]["street"]}'),
                            Text('${listaUsuarios[index]["address"]["suite"]}'),
                            Text('${listaUsuarios[index]["address"]["city"]}'),
                            Text(
                                '${listaUsuarios[index]["address"]["zipcode"]}'),
                            Text(
                                'Latitude: ${listaUsuarios[index]["address"]["geo"]["lat"]}'),
                            Text(
                                'Longitude: ${listaUsuarios[index]["address"]["geo"]["lng"]}'),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
