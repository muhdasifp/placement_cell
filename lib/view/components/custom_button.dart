import 'package:flutter/material.dart';
import 'package:placement_hub/provider/my_provider.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String child;

  const CustomButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    return GestureDetector(
      onTap: provider.isLoading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: 46,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple,
        ),
        child: provider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                child,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
