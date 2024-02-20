import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/constants.dart';
import '../../shared/components/components.dart';
import '../../shop_app_layout/shop_layout.dart';
import '../register/shopRegistreScreen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class shopLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shopLoginCubit(),
      child: BlocConsumer<shopLoginCubit , shopLoginStates>(
        listener: (context , state){
          if(state is shopLoginSeccessStates){ //200
            if( state.loginModel.status! /*if true*/ ){
              showToast(text: state.loginModel.message!, state: toastStates.SECCESS);
              cachHelper.saveData(key: 'token' , value: state.loginModel.data!.token!)
                .then((value){
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, shopLayout());
              });
            }
            else{
              print(state.loginModel.message);
              showToast(text: state.loginModel.message!, state: toastStates.ERROR);
            }
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView( // to not let the keyboard makes error on screen
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black
                            )
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'please enter ur email address';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('EMAIL ADDRESS'),
                              prefix: Icon(Icons.email_outlined)
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'password is too short';
                            return null;
                          },

                          onFieldSubmitted: (str){
                            //print('$str\n\n\n');
                            if(formKey.currentState!.validate()){
                              shopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          obscureText: shopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('password'),
                            prefix: Icon(Icons.lock_outline),
                            suffix: IconButton(
                                onPressed: (){
                                  shopLoginCubit.get(context).changePassVisibility();
                                } ,
                                icon: Icon(shopLoginCubit.get(context).suffixEyePass)
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is! shopLoginLoadingStates,
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                          builder: (context)=> defaultButton(
                            radius: 10,
                            function: (){
                              if(formKey.currentState!.validate()){
                                shopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            text: 'LOGIN' , isUppercase: true,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            //Spacer(),
                            SizedBox(width: 10,),
                            TextButton(
                                onPressed: (){
                              navigateAndFinish(context, shopRegisterScreen());
                            }, child: Text('REGISTRE'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
