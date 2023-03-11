import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steam_app/AppColors.dart';

class MyTextField extends StatelessWidget {
  final controler;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controler,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(52),
      ],
      validator: (val) => val!.isEmpty ? "Veuiller remplir ce champ" : null,
      controller: controler,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.input),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        fillColor: AppColors.input,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.placeholder),
      ),
      style: const TextStyle(color: AppColors.white),
    );
  }
}

class MyTextFieldResearch extends StatelessWidget {
  final controler;
  final String hintText;
  final bool obscureText;

  const MyTextFieldResearch(
      {super.key,
      required this.controler,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(52),
      ],
      validator: (val) => val!.isEmpty ? "Veuiller remplir ce champ" : null,
      controller: controler,
      obscureText: obscureText,
      textAlign: TextAlign.left,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.input),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          fillColor: AppColors.input,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.placeholder),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(top: 0), // add padding to adjust icon
            child: Icon(Icons.search_outlined, color: AppColors.primary),
          )),
      style: const TextStyle(color: AppColors.white),
    );
  }
}
