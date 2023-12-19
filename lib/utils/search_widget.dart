import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {Key? key,
      required this.text,
      required this.onchanged,
      required this.hinttext})
      : super(key: key);
  final String text;
  final ValueChanged<String> onchanged;

  final String hinttext;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 231, 231),
          borderRadius: BorderRadius.circular(10)),
      height: 40,
      margin: const EdgeInsets.all(14),

      //padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.search,
            size: 36,
            color: Colors.black38,
          ),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    controller.clear();

                    widget.onchanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : GestureDetector(
                  child: const Icon(Icons.close, color: Colors.red),
                  onTap: () {
                    controller.clear();

                    widget.onchanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
          hintText: widget.hinttext,
          border: InputBorder.none,
        ),
        onChanged: widget.onchanged,
      ),
    );
  }
}
