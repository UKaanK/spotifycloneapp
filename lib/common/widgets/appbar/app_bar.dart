import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotifycloneapp/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget ? title;
  final Widget ? action;
  final bool hideBack;
  final Color ? backgroundColor;
  const BasicAppBar({super.key, this.title,  this.hideBack=false, this.action, this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: title ?? const Text(''),
      centerTitle: true,
      elevation: 0,
      actions: [
        action ?? Container()
      ],
      leading: hideBack ? null : IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: context.isDarkmode ? Colors.white.withOpacity(0.03):Colors.black.withOpacity(0.04),
            shape: BoxShape.circle 
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 15,
            color: context.isDarkmode ? Colors.white:Colors.black,
          ),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
