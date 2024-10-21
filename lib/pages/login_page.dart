import 'package:chatapp/components/buttons.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordControlloer = TextEditingController();

  //singIn
  void singIn() async{
    final authService = Provider.of<AuthService>(context,listen: false);
    try{
        await authService.singInWithEmailAndPassword(
            emailController.text,
            passwordControlloer.text
        );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const SizedBox(height: 50),
                //icon
                Icon(
                  Icons.message,
                  size: 80,
                ),
                const SizedBox(height: 50),
                // Text
                Text(
                  "Chat App With Flutter",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // email textfield
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    odscureText: false,
                ),
                const SizedBox(height: 10 ),
                // password Textfield
                MyTextField(
                  controller: passwordControlloer,
                  hintText: 'Password',
                  odscureText: true ,
                ),
                const SizedBox(height: 20 ),
                MyButton(onTap: singIn, text: 'Login'),
                const SizedBox(height: 20 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản?'
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Đăng ký ngay',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[300],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

