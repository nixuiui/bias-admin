import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class DialogAlert extends StatelessWidget {
  
  final String? title;
  final String? description;
  final String? buttonTitle;
  final Widget? image;

  factory DialogAlert.success({
    String? title,
    String? description,
    String? buttonTitle = 'OK',
    Widget? image,
  }) => DialogAlert(
    title: title,
    description: description,
    buttonTitle: buttonTitle,
    image: Image.asset('assets/pngs/success.png'),
  );

  factory DialogAlert.error({
    String? title,
    String? description,
    String? buttonTitle = 'Coba Lagi',
    Widget? image,
  }) => DialogAlert(
    title: title,
    description: description,
    buttonTitle: buttonTitle,
    image: Image.asset('assets/pngs/error.png'),
  );

  const DialogAlert({ 
    Key? key,
    this.title,
    this.description,
    this.buttonTitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NxBox(
          color: Colors.white,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(32),
          borderRadius: 16,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: image ?? Image.asset('assets/pngs/error.png')
              ),
              if(title != null) Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
              ),
              if(description != null) Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  description!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              NxButton.primary(
                onPressed: () => Get.back(),
                radius: 10,
                child: Text(
                  buttonTitle ?? 'OK',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}