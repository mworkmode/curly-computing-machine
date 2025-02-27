import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:control_style/control_style.dart';
// import 'package:sura_flutter/sura_flutter.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15,),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0,bottom: 0),
            
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: widget.controller,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        color: AppColor.lightGrey
                      ),
                    ],
                ),
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grayText),
                suffixIcon: widget.suffixIcon ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ): null,
                suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                    maxHeight: 33
                ): null,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEmailInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomEmailInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false
  }) : super(key: key);

  @override
  State<CustomEmailInputField> createState() => _CustomEmailInputFieldState();
}

class _CustomEmailInputFieldState extends State<CustomEmailInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black),
            ),
          ),
          Container(
             margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0,bottom: 0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.controller,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        color: AppColor.lightGrey
                      ),
                    ],
                  ),
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayText),
                suffixIcon: widget.suffixIcon ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ): null,
                suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                    maxHeight: 33
                ): null,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
class CustomPasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomPasswordInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false
  }) : super(key: key);

  @override
  State<CustomPasswordInputField> createState() => _CustomPasswordInputFieldState();
}

class _CustomPasswordInputFieldState extends State<CustomPasswordInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 5,bottom: 5),
            child: TextFormField(
              controller: widget.controller,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        color: AppColor.lightGrey
                      ),
                    ],
                  ),
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayText),
                suffixIcon: widget.suffixIcon ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  size: 25,),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ): null,
                suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                    maxHeight: 38
                ): null,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextInputField extends StatefulWidget {
  // final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomTextInputField({
    Key? key,
    // required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _CustomTextInputField();
}

class _CustomTextInputField extends State<CustomTextInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15,),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0,bottom: 0),

            child: TextFormField(
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.words,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        color: AppColor.lightGrey
                    ),
                  ],
                ),
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayText),
                suffixIcon: widget.suffixIcon ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ): null,
                suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                    maxHeight: 33
                ): null,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDescriptionInputField extends StatefulWidget {
  // final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomDescriptionInputField({
    Key? key,
    // required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false
  }) : super(key: key);

  @override
  State<CustomDescriptionInputField> createState() => _CustomDescriptionInputField();
}

class _CustomDescriptionInputField extends State<CustomDescriptionInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15,),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0,bottom: 0),

            child: TextFormField(
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.words,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.outer,
                        color: AppColor.lightGrey
                    ),
                  ],
                ),
                isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayText),
                suffixIcon: widget.suffixIcon ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ): null,
                suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                    maxHeight: 33
                ): null,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              maxLines: null,
              minLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}