import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const Button({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onHover: (event) {},
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}

class ButtonGost extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const ButtonGost({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onHover: (event) {},
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background.withOpacity(1.0),
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: AppColors.primary)),
      child: Text(
        name,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
