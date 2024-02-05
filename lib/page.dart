import 'package:flutter/material.dart';

class Page_Home extends StatefulWidget {
  const Page_Home({super.key});

  @override
  State<Page_Home> createState() => _Page_HomeState();
}

class _Page_HomeState extends State<Page_Home> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController text = TextEditingController();
  List listData = [];
  int numero = 0;
  int valor = -1;

  clearAll() {
    numero = 0;
    valor = -1;

    Navigator.pop(context);
    text.clear();
  }

  option() {
    if (numero == 1) {
      reg_data();
    } else if (numero == 2) {
      act_data(valor);
    }

    clearAll();
  }

  reg_data() {
    if (text.text.trim().toString().isNotEmpty) {
      setState(() {
        listData.add({'data': text.text.trim()});
      });
    }
  }

  act_data(int index) {
    setState(() {
      listData[index]['data'] = text.text.trim().toString();
    });
  }

  modal(String title, String button) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(title),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: text,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => option(),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      button,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: ListView(
        children: listData
            .asMap()
            .map(
              (i, data) {
                return MapEntry(
                  i,
                  Container(
                    child: ListTile(
                      title: Text(data['data']),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          (i + 1).toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              numero = 2;
                              modal('Actualizar Dato', 'Actualizar');
                              valor = i;
                              print(data);
                              setState(() {
                                text.text = data['data'];
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                listData.removeAt(i);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            .values
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          text.clear();
          numero = 1;
          modal('Nuevo Registro', 'Registrar');
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
