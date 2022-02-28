import 'package:flutter/material.dart';

class SelectedItem extends StatefulWidget {
  final Function(bool isSelected)? onPressed;
  final String? text;

  const SelectedItem({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  bool isSelected = false;


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
        onTap: (){
         setState(() {
           isSelected = !isSelected;
           widget.onPressed!(isSelected);
         });
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected? Color(0xff4A80F0): Color(0xff1C2031),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Color(0xff4A80F0).withOpacity(0.3),
                  offset: Offset(0,4),
                  blurRadius: 10
                ),
              ]: [],
            ),
            child: Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Text(widget.text!, style: TextStyle(color: Colors.white, fontSize:  17, fontWeight: FontWeight.normal),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







