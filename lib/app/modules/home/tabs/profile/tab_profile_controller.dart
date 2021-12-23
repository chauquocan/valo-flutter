import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class TabProfileController extends GetxController {
  //user service
  final ProfileProvider userProvider = Get.find<ProfileProvider>();
  final AuthProvider authProvider = Get.find<AuthProvider>();

  //text field controller
  final TextEditingController inputName = TextEditingController();
  // final TextEditingController inputPhone = TextEditingController();
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputAdress = TextEditingController();
  final TextEditingController inputDate = TextEditingController();

  var isLoading = false.obs;
  //image
  final ImagePicker _picker = ImagePicker();
  var imageURL = '';

  final editFormKey = GlobalKey<FormState>();

  Gender selectedGender = Gender.male;

  // final gender = ''.obs;

  final currentUser = User(
          id: "",
          name: "name",
          gender: "gender",
          dateOfBirth: DateTime.now(),
          phone: "phone",
          email: "email",
          address: "address",
          imgUrl: "imgUrl",
          status: "status")
      .obs;

  final _id = ''.obs;
  final _name = ''.obs;
  final _gender = ''.obs;
  final _dateOfBirth = DateTime.now().obs;
  final _phone = ''.obs;
  final _email = ''.obs;
  final _address = ''.obs;
  final _imgUrl = ''.obs;
  final _status = ''.obs;

  String get id => _id.value;

  set id(value) {
    _id.value = value;
  }

  String get name => _name.value;

  set name(value) {
    _name.value = value;
  }

  String get gender => _gender.value;

  set gender(value) {
    _gender.value = value;
  }

  DateTime get dateOfBirth => _dateOfBirth.value;

  set dateOfBirth(value) {
    _dateOfBirth.value = value;
  }

  String get phone => _phone.value;

  set phone(value) {
    _phone.value = value;
  }

  String get email => _email.value;

  set email(value) {
    _email.value = value;
  }

  String get address => _address.value;

  set address(value) {
    _address.value = value;
  }

  String get imgUrl => _imgUrl.value;

  set imgUrl(value) {
    _imgUrl.value = value;
  }

  String get status => _status.value;

  set status(value) {
    _status.value = value;
  }

  @override
  void onInit() {
    id = LocalStorage.getUser()!.id;
    name = LocalStorage.getUser()!.name;
    gender = LocalStorage.getUser()!.gender;
    dateOfBirth = LocalStorage.getUser()!.dateOfBirth;
    phone = LocalStorage.getUser()!.phone;
    email = LocalStorage.getUser()!.email;
    address = LocalStorage.getUser()!.address;
    imgUrl = LocalStorage.getUser()!.imgUrl;
    status = LocalStorage.getUser()!.status;
    currentUser.value = User(
        id: id,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        phone: phone,
        email: email,
        address: address,
        imgUrl: imgUrl,
        status: status);
    super.onInit();
  }

  @override
  void onClose() {
    inputName.dispose();
    // inputPhone.dispose();
    inputEmail.dispose();
    inputAdress.dispose();
    super.onClose();
  }

  //upload image function
  void uploadImage() async {
    try {
      final pickedFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      isLoading(true);
      if (pickedFile != null) {
        var response = await userProvider.uploadFile(pickedFile.path);
        if (response.ok) {
          //get image url from api response
          imageURL = response.data!.imgUrl;
          await LocalStorage.updateUser(response.data!);
          customSnackbar().snackbarDialog('Success', 'Image uploaded successfully');
        } else if (response.code == HttpStatus.unauthorized) {
          customSnackbar().snackbarDialog('Unauthorization', 'token expired');
        } else {
          customSnackbar().snackbarDialog('Failed', 'Error Code: $response');
        }
      } else {
        customSnackbar().snackbarDialog('Failed', 'Image not selected');
      }
    } finally {
      isLoading(false);
    }
  }

  void pickImagesFromGallery() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["jpg","jpeg","png"]);
      isLoading(true);
      if (result != null) {
        var response = await userProvider.uploadFile(result.files.single.path);
        if (response.ok) {
          imageURL = response.data!.imgUrl;
          await LocalStorage.updateUser(response.data!);
          currentUser.value.imgUrl = response.data!.imgUrl;
          customSnackbar().snackbarDialog('Success', 'Image uploaded successfully');
        } else {
          customSnackbar()
              .snackbarDialog('failed', 'Something went wrong, try again');
        }
      }
    } finally {
      isLoading(false);
    }
  }

  //Edit profile infomation function
  Future editProfileInfo(
    String name,
    String gender,
    String email,
    String address,
    String birhDay,
  ) async {
    if (editFormKey.currentState!.validate()) {
      final map = {
        'name': name,
        'gender': gender,
        'dateOfBirth': birhDay,
        'email': email,
        'address': address,
      };
      final response = await ProfileProvider().updateUserInfo(map);
      if (response.ok) {
        Get.back();
        await LocalStorage.updateUser(response.data!);
        currentUser.value = response.data!;
        customSnackbar()
            .snackbarDialog('Susscessfully', 'Edit information susscessfully');
        Get.reload();
      } else {
        if (response.code == HttpStatus.forbidden) {
          customSnackbar()
              .snackbarDialog('failed', 'Something went wrong, try again');
        } else if (response.code == HttpStatus.unauthorized) {
          customSnackbar()
              .snackbarDialog('failed', 'Something went wrong, try again');
        } else {
          customSnackbar()
              .snackbarDialog('failed', 'Something went wrong, try again');
        }
      }
    }
  }

  //Logout
  Future logout() async {
    final response = await authProvider.logout();
    LocalStorage.logout();
    Get.deleteAll();
    Get.offAllNamed('/');
  }
}
