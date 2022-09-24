/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:valo_chat_app/app/modules/settings/setting_controller.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'languages_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final controller = Get.find<SettingController>();
  bool darkMode = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      backgroundColor: Theme.of(context).backgroundColor,
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
                title: 'language'.tr,
                subtitle: 'changelang'.tr,
                leading: Icon(Icons.language),
                onPressed: (context) => Get.to(() => LanguagesScreen())),
            SettingsTile.switchTile(
              title: 'darkmode'.tr,
              subtitle: Get.isDarkMode ? "Dark" : "Light",
              leading: const Icon(Icons.color_lens_outlined),
              switchValue: darkMode,
              onToggle: (value) {
                setState(() {
                  darkMode = value;
                  LocalStorage().changeThemeMode();
                });
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(
              title: 'phoneNumber'.tr,
              leading: const Icon(Icons.phone),
              subtitle: LocalStorage.getUser()?.phone,
            ),
            SettingsTile(
              title: 'email'.tr,
              leading: const Icon(Icons.email),
              subtitle: LocalStorage.getUser()?.email,
            ),
            SettingsTile(
              title: 'logout'.tr,
              leading: const Icon(Icons.exit_to_app),
              onPressed: (context) {
                Get.dialog(
                  AlertDialog(
                    title: const Center(child: Text('Lưu ý')),
                    content: const SingleChildScrollView(
                      child: Text('Bạn có chắc chắn muốn thoát?'),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.profileController.logout();
                        },
                        icon: const Icon(Icons.check_circle),
                        // style: ButtonStyle(backgroundColor: Colors.blue),
                        label: const Text(
                          "Xác nhận",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.cancel),
                        // style: ButtonStyle(backgroundColor: Colors.blue),
                        label: const Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: [
            SettingsTile(title: 'terms'.tr, leading: const Icon(Icons.description)),
            SettingsTile(
                title: 'licenses'.tr,
                leading: const Icon(Icons.collections_bookmark)),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 8),
                child: Image.asset(
                  'assets/icons/valo.png',
                  height: 70,
                  width: 70,
                  color: const Color(0xFF777777),
                ),
              ),
              const Text(
                'Nhóm 23',
                style: TextStyle(color: Color(0xFF777777)),
              ),
              Text(
                'version'.tr + ': 2.0',
                style: const TextStyle(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
 */