import 'package:app_06/screens/LoginScreen.dart';
import 'package:app_06/screens/RegistroScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
        title: const Text('Welcome'),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return Center(
    child: (
      Column(
        children: <Widget>[
          Text("WELCOME"),
          SizedBox(height: 30.0),
          BotonLogin(context),
          SizedBox(height: 20.0),
          BotonRegistro(context,),
         
        ],
      )
    ),
  );
}

Widget BotonLogin(context){
return(
  FilledButton(onPressed: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Login()));
  }, child: Text("Ir a Login"))
);

}

Widget BotonRegistro(context){
return(
  ElevatedButton(
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
    onPressed: (){
    Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Registro()));
  }, child: Text("Ir a Registro"))
);

}




