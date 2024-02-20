import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../shop_app_layout/shop_layout.dart';
import '../login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class shopRegisterScreen extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopRegisterCubit(),
      child: BlocConsumer<shopRegisterCubit,shopRegisterStates>(
        listener: (context , state){
          if(state is shopRegisterSeccessStates){
            if( state.loginModel.status! /*if true*/ ){
              print(state.loginModel.data!.token);
              showToast(text: state.loginModel.message!, state: toastStates.SECCESS);
              cachHelper.saveData(key: 'token' , value: state.loginModel.data!.token!).then((value){
                //important :
                token = state.loginModel.data!.token!; // to override the previous token
                navigateTo(context, shopLayout());
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
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black
                            )
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'please enter your name';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('User Name'),
                              prefix: Icon(Icons.person)
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'please enter your phone number';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Phone Number'),
                              prefix: Icon(Icons.phone)
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'please enter your email';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Email'),
                              prefix: Icon(Icons.email)
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty)
                              return 'password is too short';
                            return null;
                          },
                          // i want it only when click the register button
                          /*onFieldSubmitted: (str){
                            //print('$str\n\n\n');
                            if(formKey.currentState!.validate()){
                              shopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text
                              );
                            }
                          },*/
                          obscureText: shopRegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('password'),
                            prefix: Icon(Icons.lock_outline),
                            suffix: IconButton(
                                onPressed: (){
                                  shopRegisterCubit.get(context).changePassVisibility();
                                } ,
                                icon: Icon(shopRegisterCubit.get(context).suffixEyePass)
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is! shopRegisterLoadingStates,
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                          builder: (context)=> defaultButton(
                            text: 'register' , isUppercase: true,
                            function: (){
                              if(formKey.currentState!.validate()){
                                shopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text
                                );
                              }
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );

  }
}
