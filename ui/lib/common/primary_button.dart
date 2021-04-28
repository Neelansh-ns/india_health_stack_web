import 'package:flutter/material.dart';

/// Primary Button
class PrimaryButton extends StatelessWidget {
  /// Constructor
  const PrimaryButton(
      {@required this.onPressed,
      this.isActive = true,
      this.buttonText,
      this.isLoading = false,
      this.icon,
      this.cornerRadius});

  /// Is Active
  final bool isActive;

  /// On Pressed
  final VoidCallback onPressed;

  /// Button Text
  final String buttonText;

  /// Icon
  final Icon icon;

  final double cornerRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: (isLoading || !isActive) ? null : onPressed,
        child: Container(
            decoration: BoxDecoration(
                color: isActive ? Color(0xFF6200EE) : Color(0xffb0b0b0),
                borderRadius: BorderRadius.circular(cornerRadius ?? 2)),
            height: 34,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: isLoading
                ? Theme(
                    data: ThemeData(accentColor: Colors.white),
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ))))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: icon,
                        ),
                      Expanded(
                        child: Text(
                          '$buttonText'?.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  )),
      );
}
