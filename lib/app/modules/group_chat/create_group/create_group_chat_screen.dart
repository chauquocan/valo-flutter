part of '../group.dart';

class CreateGroupChatScreen extends GetView<CreateGroupChatController> {
  const CreateGroupChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CreateGroupChatController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: WidgetAppBar(
              title: 'Create group chat',
              actions: [
                controller.selected.length >= 2 &&
                        controller.textCtrl.toString() != ""
                    ? IconButton(
                        onPressed: () => controller.onSubmit(),
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        tooltip: 'Tạo nhóm',
                      )
                    : IconButton(
                        onPressed: () {
                          customSnackbar().snackbarDialog(
                            'Something wrong',
                            'Members must be up to 2 or Group names not null',
                          );
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        tooltip: 'Tạo nhóm',
                      ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Flexible(
                    child: GetX<CreateGroupChatController>(
                      builder: (_) {
                        return Form(
                          key: controller.nameFormKey,
                          child: Column(
                            children: [
                              WidgetField(
                                controller: controller.textCtrl,
                                validator: (value) =>
                                    Regex.fullNameValidator(value!),
                                hint: 'Enter group name',
                                padding: EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                              _buildListSelected(),
                              _buildListUser(),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// get list user
  Expanded _buildListUser() {
    final l = controller.selected;
    return Expanded(
      child: ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, i) {
          final user = controller.users[i];
          return ListTile(
            onTap: () => controller.onSelect(user),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            leading: WidgetAvatar(
              url: user.imgUrl,
              isActive: false,
            ),
            title: Text(user.name),
            trailing: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: l.contains(user) ? Colors.green : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.grey.shade200,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListSelected() {
    if (controller.selected.isEmpty) {
      return Container(
        height: 90,
        child: const Center(child: Text('Choose up to 2 person')),
      );
    } else {
      return Container(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.selected.length,
          itemBuilder: (context, i) {
            final item = controller.selected[i];
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  if (item.id != LocalStorage.getUser()?.id) {
                    controller.onSelect(item);
                  }
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        WidgetAvatar(
                          size: 60,
                          isActive: false,
                          url: item.imgUrl,
                        ),
                        item.id == LocalStorage.getUser()?.id
                            ? const SizedBox()
                            : Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(item.name.split(' ').last),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
