import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width = 120,
    this.height = 30,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading, enabled;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            onPressed: (isLoading || !enabled) ? null : onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: height * 0.5,
              ),
            ),
          ),
        ),
        if (isLoading)
          Positioned(
            width: height * 0.8,
            height: height * 0.8,
            child: CircularProgressIndicator(
              strokeWidth: height * 0.1,
            ),
          ),
      ],
    );
  }
}
