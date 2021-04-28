import 'package:flutter/material.dart';


class PillButton extends StatefulWidget {
  String buttonText;
  Function onPressed;
  bool isActive ;

  PillButton({this.buttonText, this.onPressed,this.isActive = false});

  @override
  _PillButtonState createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool active;
  @override
  void initState() {
    active = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      setState(() {
        active = !active;
      });
      widget.onPressed(active);
      },
      child: Container(
        decoration: BoxDecoration(
          color:!active?Colors.white:Color(0xFF6200EE),
            // borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color:Color(0xFF6200EE))),
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 12,bottom: 12,right: 8,left: 8),
          child: Text(widget.buttonText,
            style: TextStyle(color: active?Colors.white:Color(0xFF6200EE),fontSize: 12,fontWeight: FontWeight.w500)
            ,textAlign: TextAlign.center,),
        ),

      ),
    );
  }
}
