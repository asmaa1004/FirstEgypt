// import 'package:flutter/material.dart';
//
// class comTextBox extends StatelessWidget {
//
//   final String hint;
//   final String? Function(String?) valid;
//   final String? Function(String)? onchanged;
//   final TextEditingController mycontroller;
//   final bool passfield;
//   final bool enabled;
//   final bool readOnly;
//   final Widget? texticon;
//
//   const comTextBox(
//       {Key? key,
//         required this.hint,
//         required this.mycontroller,
//         required this.valid,
//         required this.passfield,
//         required this.enabled, this.onchanged, this.texticon,required this.readOnly})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10, bottom: 10),
//       child: TextFormField(
//         validator: valid,
//         onChanged: onchanged,
//         obscureText: passfield,
//         controller: mycontroller,
//         enabled: enabled,
//         readOnly: readOnly,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 17, color: Colors.black),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//           //hintText: hint,
//           //hintStyle: TextStyle(fontSize: 12),
//           labelText: hint,
//           prefixIcon: texticon,
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black, width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//       ),
//     );
//   }
// }
