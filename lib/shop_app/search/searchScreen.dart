import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class searchScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey<FormState>() ;
    TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => shopSearchCubit(),
      child: BlocConsumer<shopSearchCubit,searchStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String ? value){
                          if(value!.isEmpty)
                            return 'enter text to search';
                          return null;
                        },
                        onSubmit: (text){
                          shopSearchCubit.get(context).search(text: text!);
                        },
                        suffixPressed: (){},
                        label: 'search',
                        onChange: (e){},
                        prefix: Icons.search,
                        onTap: (){},
                    ),
                    SizedBox(height: 10,),
                    if(state is searchLoadingState)
                      LinearProgressIndicator(),
                    if(state is searchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        // physics: BouncingScrollPhysics(), // like refresh scrolling
                          itemBuilder: (context , index) => buildListProduct(context , shopSearchCubit.get(context).model!.data!.data[index] , isOldPrice: false),
                          separatorBuilder: (context , index) => myDivider(),
                          itemCount: shopSearchCubit.get(context).model!.data!.data.length
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
