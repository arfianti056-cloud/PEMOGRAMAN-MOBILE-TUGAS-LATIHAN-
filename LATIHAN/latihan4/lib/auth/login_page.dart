import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _globalKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check, color: Colors.white),
              ),

              SizedBox(height: 15),

              Text(
                "Task Flow",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back 👏"),
                    Text("Login untuk melanjutkan ke akun anda"),
                  ],
                ),
              ),

              SizedBox(height: 40),

              //form
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) ;
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Belum Punya Akun?"),
                        TextButton(onPressed: () {}, child: Text("Register")),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                          child: Text("Atau"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/google.jpeg',
                                width: 22,
                                height: 22,
                              ),
                              SizedBox(width: 10),
                              Text("Continue with Google"),
                            ],
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/facebook.jpeg',
                                width: 22,
                                height: 22,
                              ),
                              SizedBox(width: 10),
                              Text("Continue with Facebook"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
