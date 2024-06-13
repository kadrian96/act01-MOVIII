
import 'package:app_06/screens/ProductosScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main()  {
 
  runApp(const Formulario());
}

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ferreteria"),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return Container(
    padding: EdgeInsets.all(10),
    child: (Column(
      children: <Widget>[
        Text("Formulario de productos", style:TextStyle(color: Colors.indigo, fontSize: 20),),
        SizedBox(height: 30.0),
        CampoID(context),
        SizedBox(height: 20.0),
        CampoProducto(context),
        SizedBox(height: 20.0),
        CampoCategoria(context),
        SizedBox(height: 20.0),
        CampoPrecio(context),
        SizedBox(height: 30.0),
        BotonGuardar(context),
        SizedBox(height: 20.0),
        BotonProdutos(context)
      ],
    )
    
    
    ),
  );
}
final TextEditingController _id= TextEditingController();
final TextEditingController _producto= TextEditingController();
final TextEditingController _categoria= TextEditingController();
final TextEditingController _precio= TextEditingController();

Widget CampoID(context){
  return(
    TextFormField(
      controller: _id,
      decoration: InputDecoration(
        hintText: "Ingresar ID"
      ),

    )
  );
}

Widget CampoProducto(context){
  return(
    TextField(
      controller: _producto,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: "Ingresar Producto"),)
  );
}

Widget CampoCategoria(context){
  return(
    TextField(
      controller: _categoria,
      decoration: InputDecoration(
      hintText: "Ingrese la categoria"
    ),)
  );
}

Widget CampoPrecio(context){
  return(
    TextField(
      controller: _precio,
      decoration: InputDecoration(
      hintText: "Ingrese el precio" ),)
  );
}

Widget BotonGuardar(context){
  return(
    ElevatedButton(onPressed: (){
      guardar();
    }, child: Text("Guardar"),
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),)
  );
}

Widget BotonProdutos(context){
  return(
    ElevatedButton(onPressed: (){
        Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Productos()));
    }, child: Text("Ver Productos"),
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.indigo), foregroundColor: WidgetStatePropertyAll(Colors.white) ))
  );
}

Future<void> guardar() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("productos/"+_id.text);               //doy el nombre a la coleccion en el metodo .ref y el nombre del id con el que se va a guardar

await ref.set({
  "id": _id.text,
  "producto": _producto.text,
  "categoria": _categoria.text,
  "precio": _precio.text
});
}