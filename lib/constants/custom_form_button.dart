import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  final double? horizontalPadding;
  const CustomFormButton({Key? key, required this.innerText, required this.onPressed,this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size.width * 0.85,minWidth: size.width * 0.85,minHeight: horizontalPadding ?? 45),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(shape: WidgetStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
        )),
        backgroundColor: WidgetStateProperty.all(AppColor.kAppPrimary)),
        child: Text(innerText, style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(
            fontSize: 16,
            shadows: [
              const Shadow(color: AppColor.lightGrey,blurRadius: 10)
            ],
            fontWeight: FontWeight.w500,
            color: AppColor.black),
        ),
      ),
    );
  }
}

