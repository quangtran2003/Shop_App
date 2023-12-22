import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Color? textColor;
  final bool? hasPrefixIcon;
  final bool? hasPass;
  final String? textHint;
  final String? errorText;
  final Function(String)? onChange;
  final VoidCallback? onEditingComplete;
  const MyTextField({
    Key? key,
    this.textHint,
    this.errorText,
    this.onChange,
    this.hasPass,
    this.textColor,
    this.hasPrefixIcon,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool checkPass = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TextField(
            onEditingComplete: widget.onEditingComplete,
            onChanged: widget.onChange,
            style: TextStyle(color: widget.textColor, fontSize: 17),
            obscureText: widget.hasPass != null ? !checkPass : checkPass,
            decoration: InputDecoration(
                prefixIcon: widget.hasPrefixIcon != null
                    ? const Icon(Icons.search)
                    : null,
                hintText: widget.textHint,
                focusColor: Colors.purple,
                // fillColor: widget.textColor,
                fillColor: const Color.fromARGB(255, 195, 75, 216),
                filled: false,
                suffixIcon: widget.hasPass != null
                    ? checkPass
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                checkPass = !checkPass;
                              });
                            },
                            icon: const Icon(Icons.visibility_outlined,
                                color: Colors.purple))
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                checkPass = !checkPass;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.purple,
                            ))
                    : null,
                hintStyle: TextStyle(
                    color: widget.textColor ?? Colors.purple, fontSize: 18),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: widget.textColor ?? Colors.purple),
                    borderRadius: BorderRadius.circular(20))),
          ),
          if (widget.errorText != null)
            Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.errorText}',
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            )
        ],
      ),
    );
  }
}
