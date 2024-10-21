import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/buttons.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordControlloer = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // signup
  void signUp() async {
    if(confirmPasswordController.text != passwordControlloer.text){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Mật khẩu không trùng khớp,vui lòng nhập lại!"),
        ),
      );
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context, listen:  false);
    try{
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordControlloer.text,
      );
    } catch (e){
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
                  "Tạo Tài Khoản Mới",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Nhập email',
                  odscureText: false,
                ),
                const SizedBox(height: 10 ),
                // password Textfield
                MyTextField(
                  controller: passwordControlloer,
                  hintText: 'Nhập mật khẩu',
                  odscureText: true ,
                ),
                const SizedBox(height: 10 ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Nhập lại mật khẩu',
                  odscureText: true ,
                ),
                const SizedBox(height: 20 ),
                MyButton(onTap: signUp, text: 'Đăng Ký'),
                const SizedBox(height: 20 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Text(
                        'Bạn đã có tài khoản?'
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Đăng nhập ngay',
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
