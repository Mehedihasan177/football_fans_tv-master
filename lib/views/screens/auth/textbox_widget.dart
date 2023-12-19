import 'package:flutter/material.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_sizes.dart';

class TextboxWidget extends StatefulWidget {
  const TextboxWidget({
    Key? key,
    required this.title,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.isPassword = false,
    this.hintText,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? hintText;

  @override
  State<TextboxWidget> createState() => _TextboxWidgetState();
}

class _TextboxWidgetState extends State<TextboxWidget> {
  bool _passwordVisible1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: AppSizes.size15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
              obscureText: _passwordVisible1,
              keyboardType: widget.keyboardType,
              onChanged: (value) {
                //   log(widget.controller.text);
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: AppSizes.size15,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.league.withOpacity(.5),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
                          });
                        },
                      )
                    : const SizedBox(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.hintText;
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}
