import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steam_app/resources/AppColors.dart';

class MyTextField extends StatelessWidget {
  final controler;
  final String hintText;
  final bool obscureText;
  final bool error;

  const MyTextField(
      {super.key,
      required this.controler,
      required this.hintText,
      required this.obscureText,
      required this.error});

  @override
  Widget build(BuildContext context) {
    return error
        ? TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(52),
            ],
            validator: (val) =>
                val!.isEmpty ? "Veuiller remplir ce champ" : null,
            obscureText: obscureText,
            textAlign: TextAlign.center,
            cursorColor: AppColors.white,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.error),
                ),
                fillColor: AppColors.input,
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.placeholder),
                suffixIcon: const Padding(
                  padding:
                      EdgeInsets.only(top: 0), // add padding to adjust icon
                  child: Icon(Icons.error, color: AppColors.error),
                )),
            style: const TextStyle(color: AppColors.white),
          )
        : TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(52),
            ],
            validator: (val) =>
                val!.isEmpty ? "Veuiller remplir ce champ" : null,
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
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.error),
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
  final formKey;
  final Function() action;

  const MyTextFieldResearch(
      {super.key,
      required this.controler,
      required this.hintText,
      required this.obscureText,
      required this.formKey,
      required this.action});

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
      onFieldSubmitted: (value) {
        if (formKey.currentState.validate()) {
          //formKey.currentState.save();
          action();
        }
      },
    );
  }
}
