import 'package:app_06/screens/Formulario.Screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Productos());
}

class Productos extends StatelessWidget {
  const Productos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<dynamic, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('productos');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
     // print('Datos recibidos de Firebase: $data');
      updateProductList(data);
    });
  }

  void updateProductList(dynamic data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];
        data.forEach((value) {
          if (value != null && value['producto'] != null && value['precio'] != null && value['categoria'] != null) {
            tempList.add({
              "producto": value['producto'],
              "precio": value['precio'],
              "categoria": value['categoria']
            });
          } else {
           // print('Dato con estructura inválida: $value');
          }
        });
      
      setState(() {
        productList = tempList;
      });
     // print('Lista de productos actualizada: $productList');
    } else {
      print('No se recibieron datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: 
          ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${productList[index]["producto"]}'),
                subtitle: Text('Precio: ${productList[index]["precio"]}, Categoría: ${productList[index]["categoria"]}'),
              );
            },
            
          ),
         
      
    );
  }
}
/*
Widget BotonFormulario(context){
  return(
    ElevatedButton(onPressed: (){
        Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Formulario()));
    }, child: Text("Ver Productos"),
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.indigo), foregroundColor: WidgetStatePropertyAll(Colors.white) ))
  );
}*/