import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color textColor;
  final String title;
  final Function onPressed;

  PrimaryButton({
    this.color,
    this.borderColor,
    this.textColor,
    this.title,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white.withOpacity(0.0),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            height: 47.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color,
              border: Border.all(
                color: borderColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Google Sans Medium',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 27.5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
