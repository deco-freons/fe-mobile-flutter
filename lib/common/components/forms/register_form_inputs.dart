import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/regex.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';

class RegisterFormInputs {
  static List<CustomFormInput> inputList = [
    CustomFormInput(label: 'First Name', type: TextFieldType.string),
    CustomFormInput(label: 'Last Name', type: TextFieldType.string),
    CustomFormInput(
        label: 'Email', type: TextFieldType.string, errorMessage: "error"),
    CustomFormInput(
        label: 'Password',
        type: TextFieldType.password,
        pattern: passwordPattern,
        errorMessage: "Password must be 8-20 character (including number)"),
    CustomFormInput(
        label: 'Birth Date',
        type: TextFieldType.date,
        firstDate: DateTime(1900),
        lastDate: DateTime.now())
  ];
}
