part of '../widgets.dart';

class CustomDialog {
  confirmDialog(
      String title, String mess, Function()? submit, Function()? cancel) {
    Get.dialog(
      AlertDialog(
        title: Center(child: Text(title)),
        content: SingleChildScrollView(
          child: Text(mess),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton.icon(
            onPressed: submit,
            icon: Icon(Icons.check_circle),
            // style: ButtonStyle(backgroundColor: Colors.blue),
            label: Text(
              "Xác nhận",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton.icon(
            onPressed: cancel,
            icon: Icon(Icons.cancel),
            // style: ButtonStyle(backgroundColor: Colors.blue),
            label: Text(
              "Hủy",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }

  showInfoDialog(String title, String mess, String textButton, Icon iconButton,
      Function()? tryAgain) {
    Get.dialog(
      AlertDialog(
        title: Center(child: Text(title)),
        content: SingleChildScrollView(
          child: Text(mess),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton.icon(
            onPressed: tryAgain,
            icon: iconButton,
            label: Text(
              textButton,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
