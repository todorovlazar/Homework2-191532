
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework2_191532/screens/body_calculator_screen.dart';
import 'package:homework2_191532/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {

  static String id = '/register';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen>{

  static const String _title = 'MyHealthyBody Sign Up Page';
  late String email;
  late String password;
  late String fullName;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: (isLoading)
      ? const Center(
        child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: Color(0xff676FA3),
              strokeWidth: 3,
            )),
      ) :
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Container(
                      child: Transform.translate(
                          offset: const Offset(-60, -50),
                          child: Image.asset('assets/images/MyHealthyBodyLogo.png')),
                    ),
                  )
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Transform.translate(
                      offset: const Offset(0, -70),
                      child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.bold)
                      ),
                    )
                )
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Container(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
                    },
                    child: const Text(
                      "Already have account? Login here.",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  )
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 0, bottom: 0
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full name (First and Last name)',
                      ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child:  Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email address',
                      hintText: 'Enter valid e-mail as lazar.todorov@test.com'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final newUser =
                      await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (newUser != null) {
                        setState(() {
                          isLoading = true;
                        });

                        Navigator.pushNamed(context, '$BodyCalculatorScreen.id');
                      }
                    } catch (e) {}
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}