import 'package:flutter/material.dart';

class WidgetTools {
  static Future<String> selectDate(
      BuildContext context, TextEditingController controller,
      {DateTime? initialDate}) async {
    final DateTime? pickedTime = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)).then((value) => value ?? DateTime.now());
    return "${pickedTime!.toLocal()}".split(' ')[0];
  }

  static Widget createTextField(
      TextEditingController controller, String labelText,
      {String? hintText, String? errorText, TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        validator: (value) => errorText == null
            ? null
            : value!.isEmpty
                ? errorText
                : null,
      ),
    );
  }

  static Widget createDatePickerField(
      String labelText, TextEditingController controller, BuildContext context,
      {DateTime? initialDate, String? errorText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode()); // no keyboard
          controller.text =
              await selectDate(context, controller, initialDate: initialDate);
        },
        controller: controller,
        validator: (value) => errorText!.isEmpty
            ? null
            : value!.isEmpty
                ? errorText
                : null,
      ),
    );
  }

  static Widget createDropDown(String labelText, List<String> items, { required void Function(String?) onChanged,
      String? errorText, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField(
        
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: value,
        onChanged: onChanged,
        
        validator: (value) => errorText!.isEmpty
            ? null
            : value!.isEmpty
                ? errorText
                : null,
      ),
    );
  }

  static Widget createDropDownMap(String labelText, Map<String, String> items, { required void Function(String?) onChanged,
      String? errorText, String? defaultValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        items: items.entries.map((MapEntry<String, String> value) {
          return DropdownMenuItem<String>(
            value: value.value,
            child: Text("${value.value} - ${value.key}"),
          );
        }).toList(),
        value: defaultValue,
        onChanged: onChanged,
        
        validator: (value) => errorText == null ?
        null :
        value!.isEmpty
            ? errorText
            : null,
      ),
    );
  }
  static Widget createButton(
      {required String label,
      required VoidCallback? onPress,
      GlobalKey<FormState>? formKey,
      double? fontSize = 15}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: () => formKey == null
              ? onPress!()
              : formKey.currentState!.validate()
                  ? onPress!()
                  : null,
          child: Text(label,
              style: TextStyle(
                fontSize: fontSize,
              ))),
    );
  }

  // switch widget
  static Widget createSwitch(
      {required String label,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label),
          Switch(
            value: value,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    ));
  }

  static void showAlertDialog(
      BuildContext context, String title, String message,
      {VoidCallback? onOk, List<Widget>? actions}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions ??
                [
                  TextButton(
                      onPressed: () {
                        if (onOk != null) {
                          onOk();
                        }
                      },
                      child: const Text("OK"))
                ],
          );
        });
  }
  static void showConfirmDialog(BuildContext context, String title, String message,
      {required VoidCallback onOk, VoidCallback? onCancel}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              
              TextButton(
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel();
                    } else {
                      // close dialog
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    onOk();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
  // show loading screen asynchoronously until the future is completed
  static Future<void> showLoadingScreen<E>(BuildContext context,
      {required Future<E> future, Function(E)? callback}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (callback != null) callback(snapshot.data as E);
                if (snapshot.connectionState == ConnectionState.done) {
                  Navigator.pop(context);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        });
  }
  // dimiss loading screen

}
