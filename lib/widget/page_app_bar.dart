import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget {
  const PageAppBar({
    super.key,
    this.dateController,
    this.passengerNumberController,
    this.trailing,
    this.title,
    this.leading,
  });

  final TextEditingController? dateController;
  final TextEditingController? passengerNumberController;
  final Widget? trailing;
  final Widget? title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
        left: MediaQuery.of(context).size.width * 0.025,
        right: MediaQuery.of(context).size.width * 0.025,
      ),
      leading: leading == null ? null : leading,
      title: title == null ? SizedBox() : title,
      subtitle: dateController == null || passengerNumberController == null
          ? SizedBox()
          : Text(
              dateController!.text +
                  " - " +
                  passengerNumberController!.text +
                  " passengers",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.033),
            ),
      trailing: trailing,
    );
  }
}
