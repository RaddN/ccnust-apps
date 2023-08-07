// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'mgdbHelper/mongodb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  bool rem = false;
  final emailinput = TextEditingController();
  final passwordinput = TextEditingController();
  bool loginsuccess = false;
  var alert = "";
  void logincontroll({email,password}) async {
  MongoDatabase.login(email, password).then((value) {
    if(value == "Successfully logged in"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),));
    }
    else{
      setState(() {
            alert = value.toString();
          });
    }
  });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailinput.dispose();
    passwordinput.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(child: Image.asset("assets/ccnustlogo.png")),
            const SizedBox(height: 15,),
            const Center(child: Text("Information Management System",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green
            ),)),
            const SizedBox(height: 15,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 8.0,bottom: 8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.groups_rounded),
                        SizedBox(width: 15,),
                        Text("Please Enter Your Information",style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: TextField(
                      controller: emailinput,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.manage_accounts)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: TextField(
                      controller: passwordinput,
                      obscureText: _passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(alert,style: const TextStyle(color: Colors.redAccent)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: rem, onChanged: (value) {
                              setState(() {
                                rem = value!;
                              });
                            },),
                            const Text("Remember Me"),
                          ],
                        ),
                        ElevatedButton(onPressed: () {
                          logincontroll(email: emailinput.text,password: passwordinput.text);
                        },style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 15))
                        ), child: Row(
                          children: const [
                            Icon(Icons.login,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Login",style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(onPressed: () {

                        }, icon: const Icon(Icons.arrow_back), label: const Text("Student Register")),
                        InkWell(
                          onTap: () {

                          },
                          child: Row(
                            children: const [
                              Text("I forgot my password"),
                              Icon(Icons.arrow_forward_outlined)
                            ],
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15,),
            const Center(
              child: Text("Artificial Intelligent Technology",style: TextStyle(
                color: Colors.white
              )),
            )
          ],
        ),
      ),
    );
  }
}
