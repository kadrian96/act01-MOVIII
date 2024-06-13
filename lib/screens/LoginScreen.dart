import 'package:app_06/screens/Formulario.Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main()  async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

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
        title: const Text("Login"),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return Container(
    padding: EdgeInsets.all(10),
    decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.pexels.com/photos/3255761/pexels-photo-3255761.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover)),

    child: (
     Column(
       children: <Widget>[
        Text("Login", style: TextStyle(fontSize: 20),),
        SizedBox(height: 30.0),
        CampoCorreo(context),
        SizedBox(height: 20.0),
        CampoContrasenia(context),
         SizedBox(height: 30.0),
        ButonRegistro(context)
       ],
     )
    ),
  );
}

final TextEditingController _correo = TextEditingController();
final TextEditingController _contrasenia = TextEditingController();


Widget CampoCorreo(context){
return(
 TextField(
    controller: _correo,
      decoration: InputDecoration(
        hintText: "Ingrese correo"),)
);
}

Widget CampoContrasenia(context){
return(
 TextField(
    controller: _contrasenia,
    obscureText: true,
      decoration: InputDecoration(
        hintText: "Ingrese contraseña"),)
);
}

Widget ButonRegistro(context){
  return(
    FilledButton(onPressed: (){
      
       login(context);
    }, child: Text("Login"))
  );
}

void login(context) async{
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _correo.text,
    password: _contrasenia.text,
    
  );
  //////////////////////////////////////////////////////////
     Navigator.push(context, 
      MaterialPageRoute(builder: (context)=>Formulario()));
    //////////////////////////////////////////////////////////
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    alerta01(context);

  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    alerta02(context);
  } else{
    alerta03(context);
  }
}
}

void alerta01(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: const Text("El usuario no se encontro"),
        actions: [
          
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
void alerta02(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: const Text("contraseña del usuario incorrecta"),
        actions: [
          
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
void alerta03(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: const Text("La credenciales ingresadas son incorrectas"),
        actions: [
          
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}