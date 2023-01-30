import 'package:flutter/material.dart';
import 'package:get/get.dart';

 class MySizedBoxWidget extends StatelessWidget {
  double? height;
  double? width;
  Widget? widget;
MySizedBoxWidget(
  this.height,
  this.width,
  this.widget,
   {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width:  width,
      child: widget,
    );
    
  }
}

class MyAppBarWidget extends PreferredSize {
       Size? size;
      Color? backgroundColor;
      Widget title;
       Widget? leading;
      MyAppBarWidget(
        this.backgroundColor, 
        this.title,
       // this.actions,
        this.leading,
       // this.size,
        {super.key}) : super(child: title , preferredSize: Size(Get.width/15, Get.height/15),);

  @override
  Widget build(BuildContext context) {
    return AppBar(
     backgroundColor: backgroundColor,
     title: title,
     leading: leading,
    );
  }
}

/*class Button extends StatelessWidget{
  Function()? onpressed;
  Widget child;
  Color? color;
  EdgeInsetsGeometry? hor;
  OutlinedBorder? shapeStyle;
  
  Button(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
       onPressed: onpressed, 
     
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: hor,
        shape: shapeStyle,
      ),
      child: child,
    );
    
  }
}*/

//buton metotu
   ElevatedButton buttonMethod(
    onpressed, 
    Color color,
    EdgeInsetsGeometry hor,
    Widget widget,
    [double? elevation]
    ){
      return ElevatedButton(
            onPressed: onpressed,
            style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: color,
            padding: hor,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            ),
            child: widget,
             );
  }
  