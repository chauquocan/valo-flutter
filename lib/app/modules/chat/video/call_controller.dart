// import 'package:get/get.dart';

// import 'package:permission_handler/permission_handler.dart';

// import 'package:agora_rtc_engine/rtc_engine.dart';

// const appId = "a26be3d4d5e640a994c6dc0ffbaf1b43";
// const token =
//     "006a26be3d4d5e640a994c6dc0ffbaf1b43IADBS4pDaWAPe7pIPJEw7sTpo73O9UNylJ0Tw36CM7da3UD6g3QAAAAAEABf0ripMcagYQEAAQAwxqBh";

// class CallController extends GetxController {
//   final _remoteUid = null.obs;
//   late RtcEngine _engine;

//   get remoteUid => _remoteUid.value;

//   set remoteUid(value) {
//     _remoteUid.value = value;
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     initForAgora();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _engine.destroy();
//   }

//   Future<void> initForAgora() async {
//     await [Permission.microphone, Permission.camera].request();

//     _engine = await RtcEngine.create(appId);

//     await _engine.enableVideo();

//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//           print('Local user $uid joined');
//         },
//         userJoined: (int uid, int elapsed) {
//           print('Remote user $uid joined');
//           remoteUid = uid;
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print('Remote user $uid left channel');
//           remoteUid = null;
//         },
//       ),
//     );
//     await _engine.joinChannel(token, 'firstChannel', null, 0);
//   }
// }
