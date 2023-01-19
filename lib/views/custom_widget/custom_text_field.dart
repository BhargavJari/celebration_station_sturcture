import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';

import '../../utils/colors_utils.dart';
import '../../utils/fontfamily_utils.dart';

class CustomTextField extends StatefulWidget {
  final String? hintName;
  final String? fieldName;
  final TextInputType? keyboard;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? fieldController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormat;
  final int? maxLines;
  final String? counterText;
  final bool? readonly;
  final int? maxLength;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChange;
  const CustomTextField(
      {Key? key,
      this.fieldName,
      this.textInputAction,
      this.maxLength,
      this.keyboard,
      this.readonly,
      this.contentPadding,
      this.hintName,
      this.fieldController,
      this.maxLines,
      this.onChange,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.inputFormat,
      this.counterText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.fieldController,
          obscureText: widget.obscureText ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormat ?? [],
          keyboardType: widget.keyboard,
          readOnly: widget.readonly ?? false,
          onChanged: widget.onChange ?? null,
          validator: widget.validator ?? null,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(color: Colors.green, width: 1.5)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(color: Colors.lime, width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(color: Colors.black, width: 1.5)),

            counterText: widget.counterText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintName,
            hintStyle: FontTextStyle.poppinsS14HintColor,
            //border: InputBorder.none,
            fillColor: ColorUtils.whiteColor,
            filled: true,
            // isDense: true,
            //contentPadding:widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 4.w)
          ),
        ),
      ],
    );
  }
}
