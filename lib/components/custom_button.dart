import 'package:flutter/material.dart';

class PostCustomButton extends StatelessWidget {
  void Function()? onTap;
  PostCustomButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        child: Icon(
          Icons.send_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
