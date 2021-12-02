part of '../group.dart';

class AddMemberScreen extends GetView<AddMemberController> {
  final chatController = Get.find<ChatController>();

  AddMemberScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add new member',
            style: TextStyle(color: AppColors.light),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: GetX<AddMemberController>(
          builder: (_) => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.users.length,
            itemBuilder: (context, i) {
              final user = controller.users[i];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onLongPress: () {},
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 30,
                    backgroundImage: NetworkImage(user.imgUrl),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.addMember(user.id, chatController.id);
                      Get.back();
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
