import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String labelText;
  final Function onPressed;
  final bool loading;
  final double width;

  PrimaryButton({this.labelText, this.width, this.onPressed, this.loading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      child: RaisedButton(
        color: Colors.transparent,
        onPressed: onPressed,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: new BoxDecoration(
                borderRadius:
                    new BorderRadius.all(const Radius.circular(150.0)),
                gradient: new LinearGradient(
                  colors: [
                    theme.backgroundColor,
                    theme.accentColor,
                  ],
                )),
            padding: const EdgeInsets.all(10.0),
            child: (loading ?? false)
                ? Center(
                    child: Container(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: .5,
                        )))
                : Text(
                    labelText ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      ),
    );
  }
}
