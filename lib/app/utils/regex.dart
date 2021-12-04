import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class Regex {
  static bool isName(String name) {
    RegExp regExp = RegExp(
        r"^[\S][a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s+]+[\S]$");
    return regExp.hasMatch(name);
  }

  static bool isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r"[a-z]"))) return false;
    if (!password.contains(RegExp(r"[A-Z]"))) return false;
    if (!password.contains(RegExp(r"[0-9]"))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  //Validator
  static String? fullNameValidator(String value) {
    if (value.isEmpty) {
      // customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa nhập họ tên');
      return 'Please enter your name';
    }
    if (!isName(value)) {
      // customSnackbar().snackbarDialog('Lỗi', 'Tên không hợp lệ');
      return 'Invalid name';
    }
    return null;
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      // customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa nhập email');
      return 'Please enter your email';
    }
    if (!value.isEmail) {
      // customSnackbar().snackbarDialog('Lỗi', 'Email không hợp lệ');
      return 'Invalid email';
    }
    return null;
  }

  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      // customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa nhập mật khẩu');
      return 'Please enter password';
    }
    if (!isPasswordValid(value)) {
      customSnackbar().snackbarDialog('Lưu ý',
          'Mật khẩu tối thiểu 8 kí tự bao gồm chữ thường, chữ hoa, số, kí tự đặc biệt');
      return 'Invalid password';
    }
    return null;
  }

  static String? confirmPasswordValidator(String value, String password) {
    if (value.isEmpty) {
      // customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa xác nhận lại mật khẩu');
      return 'Please confirm password';
    }
    if (!(value.compareTo(password) == 0)) {
      return 'Wrong password';
    }
    return null;
  }

  static String? phoneValidator(String value) {
    if (value.isEmpty) {
      customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa nhập số điện thoại!');
      return 'Please enter phone number';
    }
    if (!value.isPhoneNumber) {
      customSnackbar().snackbarDialog('Lỗi', 'Số điện thoại không hợp lệ!');
      return 'Invalid phone number';
    }
    return null;
  }

  static String? pinValidator(String value) {
    if (value.isEmpty) {
      // customSnackbar().snackbarDialog('Lỗi', 'Bạn chưa nhập mã xác thực!');
      return 'Please enter OTP Code';
    }
    if (value.length < 6) {
      // customSnackbar().snackbarDialog('Lỗi', 'Mã xác thực gồm 6 số!');
      return 'OTP Code must have 6 digits';
    }
    return null;
  }

  static bool isAddress(String name) {
    RegExp regExp = RegExp(
        r"^[\S][a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ.,/\s+]+[\S]$");
    return regExp.hasMatch(name);
  }

  static String? addressValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter address';
    }
    if (value.length < 2) {
      return 'Invalid address';
    }
    if (!isAddress(value)) {
      return 'Invalid address';
    }
    return null;
  }
}
