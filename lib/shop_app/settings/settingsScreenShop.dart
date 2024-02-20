import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/login_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shop_app_layout/cubit/shopLayoutCubit.dart';
import '../../shop_app_layout/cubit/shopLayoutStates.dart';


class settingsScreenShop extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController  nameController = TextEditingController() ;
  TextEditingController  emailController = TextEditingController() ;
  TextEditingController  phoneController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body : BlocConsumer<shopCubit,shopStates>(
        listener: (context , state){
          /* we can't cuz the time of actual state is tooo short
          if(state is shopSuccessGetLoginDataState)
            nameController.text = state.data!.name! ; */
        },
        builder: (context , state){
          shopCubit cubit = shopCubit.get(context);

          shopAppLoginModel ?  model = shopCubit.get(context).get_login_data!;
          if(model != null){
            nameController.text = model.data!.name! /*??''*/  ;
            phoneController.text = model.data!.phone! /*??''*/;
            emailController.text = model.data!.email! /*??''*/;
          }


          return ConditionalBuilder(
            condition: cubit.get_login_data != null,
            builder:(contex)=> Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is shopLoadingUpdateUserDataState)
                       LinearProgressIndicator() ,
                    SizedBox(height: 20,), // lazm bach yban progression
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate:(String ? value){
                          if(value!.isEmpty)
                            return 'name must not be empty';
                          return null ;
                        },
                        suffixPressed: (){}, // zayda hna
                        label: 'Name',
                        onChange: (s){}, // zayda hna
                        prefix: Icons.person,
                        onTap: (){}
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate:(String ? value){
                          if(value!.isEmpty)
                            return 'email must not be empty';
                          return null ;
                        },
                        suffixPressed: (){}, // zayda hna
                        label: 'Email',
                        onChange: (q){}, // zayda hna
                        prefix: Icons.email,
                        onTap: (  ){}
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate:(String ? value){
                          if(value!.isEmpty)
                            return 'phone must not be empty';
                          return null ;
                        },
                        suffixPressed: (){}, // zayda hna
                        label: 'Email',
                        onChange: (s){}, // zayda hna
                        prefix: Icons.phone,
                        onTap: (){}
                    ),
                    SizedBox(height: 20,),
                    defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            cubit.updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text
                            );
                          }
                        },
                        text: 'update'
                    ),
                    SizedBox(height: 20,),
                    defaultButton(
                        function: (){
                          sighOut(context);
                        },
                        text: 'Logout'
                    ),

                  ],
                ),
              ),
            ),
            fallback: (contex)=> Center(
              child: CircularProgressIndicator(),
            ) ,
          );
        }
      )
    );
  }
}
