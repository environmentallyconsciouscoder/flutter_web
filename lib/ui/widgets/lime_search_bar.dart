import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  final dynamic controller;
  final dynamic submit;

  const SearchBarView({Key? key, this.controller, this.submit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: "Type address (point of interest) and click submit",
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => {submit()},
              )),
        ),
      ],
    );
  }
}
