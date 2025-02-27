import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/text_form_field_label.dart';
import '../../theme/app_colors.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final TextEditingController textController = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 0,),
            const Text(
            "Withdraw",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 32,
                fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            const Text(
              "Add your withdraw request",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20,),
            Form(
              key: form,
              child: TextFormFieldLabel(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                lebelText: 'Enter amount',
                lebelFontColor: const Color(0xff1A1A1A),
                borderRadius: BorderRadius.circular(10.0),
                hint: 'Enter amount',
                controller: textController,
                // focusNode: signupVM.lastNameFocusNode.value,
                validating: (value) {
                  if (value!.isEmpty) {
                    return 'Enter amount';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20,),
            withdrawFundButton(onPressed: () {
              if(form.currentState!.validate()){
                Get.dialog(
                  barrierDismissible: false,
                  AlertDialog(
                    title: const Text("Request Submitted Successfully"),
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
                    actions: [
                      ElevatedButton(onPressed: (){
                        textController.clear();
                        form.currentState!.reset();
                        Navigator.of(context).pop();
                      }, child: const Text("Done")),
                    ],
                    contentTextStyle: const TextStyle(fontSize: 15, color: Colors.black87),
                    content: const Text("The amount will be transferred to your account within 24 to 48 hours"),
                  )
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget withdrawFundButton({required void Function()? onPressed}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 6,horizontal: 25)),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          )),
          backgroundColor: WidgetStateProperty.all(const Color(0xfffc8805))
      ),
      child: Text('Submit', style: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.white),
      ),
    );
  }
}
