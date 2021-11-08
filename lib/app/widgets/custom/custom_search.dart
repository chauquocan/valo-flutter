import 'package:flutter/material.dart';
import 'package:valo_chat_app/app/data/models/user.dart';

//Custom contact card in contact tab
class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key, required this.user}) : super(key: key);
  final ProfileResponse user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              backgroundImage: NetworkImage('${user.imgUrl}'),
            ),
            title: Text(
              user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.phone),
            trailing: IconButton(
                onPressed: () {
                  print('gui ket ban');
                },
                icon: Icon(Icons.add)),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
