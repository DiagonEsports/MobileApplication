import 'package:flutter/material.dart';

class CenteredButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color textColor;
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function onPressed;

  CenteredButton({
    this.color,
    this.borderColor,
    this.textColor,
    this.title,
    this.icon,
    this.iconColor,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: iconColor,
                  size: 22.5,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Google Sans',
                    fontSize: 20.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
