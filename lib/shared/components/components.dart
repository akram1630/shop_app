import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shop_app_layout/cubit/shopLayoutCubit.dart';

import '../../models/shop_app/homeModel.dart';
import '../styles/colors.dart';

// parameters required or (optional-default)
Widget defaultButton(
        {double radius = 0,
        double width = double.infinity,
        Color color = Colors.blue,
        required void function(),
        required String text,
        bool isUppercase = true}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        void onSubmit(String? h)?, // we will be back after dart revision
        //Function onChanged ,
        bool isPassword = false,
        required String? Function(String? h) validate, // ? can return null
        required void suffixPressed(), //no required should
        required String label,
        required void onChange(dynamic? h),
        required IconData prefix,
        IconData? suffix,
        required void onTap() //we will be back

        }) =>
    TextFormField(
      onTap: onTap,
      controller: controller, // the value entered
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
          labelText: label, // value
          prefixIcon: Icon(prefix),
          suffix: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed,
                )
              : null,
          border: OutlineInputBorder() // shape of cadre form
          ),
      keyboardType: type, // type='email'
      onChanged: onChange,

      onFieldSubmitted: onSubmit,
/*onChanged: (String valeur){ // print and concatinat all char entered
                            print("Onchanged---> ${valeur}");
                          },
*/
    );

/*************************************/
Widget myDivider() => Padding(
      padding: EdgeInsetsDirectional.only(start: 20),
      child: Container(
        color: Colors.grey,
        width: double.infinity,
        height: 2,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, //// we can't return the previous screen when we click back
    MaterialPageRoute(
      // and it will get u out of the app (quitter)
      builder: (context) => widget,
    ),
    (route) => false // we shoud put false to not return
    );
/********************SHOP_APP*****************************/
void showToast({required String text, required toastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastStates { SECCESS, ERROR, WARNING } // like a mini class

Color chooseToastColor(toastStates state) {
  Color color;
  switch (state) {
    case toastStates.SECCESS:
      color = Colors.green;
      break;
    case toastStates.ERROR:
      color = Colors.red;
      break;
    case toastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(
    context, model /* we should persize which class or sub class or let it*/,
    {bool isOldPrice = true}) {
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(model.image! ?? 'vide'),
              width: 120,
              height: 120,
              //fit: BoxFit.cover, //fix resolution to fill all + zoom
            ),
            if (isOldPrice) // cause product in search doesn't have discount and old_price
              if (model.discount! != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )
          ]),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name! ?? 'nool',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, height: 1.3 // like sizedBox among Lines
                      ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString() ?? 'vide',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: defaultColor
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (isOldPrice) // cause product in search doesn't have discount and old_price
                      if (model.discount != 0)
                        Text(
                          model.old_price.toString() ?? 'nool',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration
                                  .lineThrough // line on old price
                              ),
                        ),
                    Spacer(), // max sizedBox
                    if( shopCubit.get(context).favorites[model.id!] != null)
                    IconButton(
                      onPressed: () {
                        shopCubit
                            .get(context)
                            .changeFavorites(productId: model.id! ?? 'nool');
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            shopCubit.get(context).favorites[model.id!]!
                                ? defaultColor
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
// padding: EdgeInsets.zero , //no padding
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
