// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:valo_chat_app/app/data/models/contact_model.dart';

// //Custom contact card in contact tab
// class CustomContact extends StatelessWidget {
//   const CustomContact({Key? key, required this.contact}) : super(key: key);
//   final ContactCustom contact;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onLongPress: () {},
//       onTap: () {},
//       child: Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.blueGrey,
//               radius: 30,
//               child: SvgPicture.asset(
//                 'assets/icons/${contact.icon}',
//                 height: 38,
//                 width: 38,
//               ),
//               // backgroundImage: NetworkImage('${contact.icon}'),
//             ),
//             title: Text(
//               contact.name.toString(),
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(contact.phone.toString()),
//           ),
//         ],
//       ),
//     );
//   }
// }
