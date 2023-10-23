import 'package:ecommerce_app/auth/auth_service.dart';
import 'package:ecommerce_app/pages/dashboad_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   bool isObscure=true;
   String errMsg='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon:  Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4),
                child: TextFormField(
                  obscureText: isObscure,
                  controller: _passController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    _loginAdmin();
                  },
                  child: const Text('LOGIN'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:50,vertical: 15),
                child: Text(errMsg,style:const TextStyle(
                  fontSize: 16,
                  color:Colors.red,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginAdmin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passController.text;
      EasyLoading.show(status: 'Please wait');
      try {
        final status = await AuthServices.loginAdmin(email, password);
        EasyLoading.dismiss();
      if(status) {
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }
      else{
        await AuthServices.logout();
        setState(() {
          errMsg='This email is not associated with an Admin account.';
        });
      }
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
       setState(() {
         errMsg=error.message!;
       });
      }
    }
  }
}
