String? validateEmail(String? value) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!regex.hasMatch(value!)) {
    return 'Digite un email válido';
  } else {
    return null;
  }
}

String? validateDireccion(String value) {
  if (value.length < 6) {
    return 'Digite una direccion válida';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value!.length < 8) {
    return 'Contraseña debe ser de minimo 8 caracteres';
  } else {
    return null;
  }
}

String? validateConfirmPassword(String value, String controllPassword) {
  if (value.isEmpty) return 'Por favor, llene este campo';
  if (value != controllPassword) return 'No coinciden las contraseñas';
  return null;
}

/*-------------------------------------REGISTRO step 2-------------------------------------*/
String? validateString(String? value, int lenght) {
  RegExp regExp = RegExp(r'^[a-zA-ZZáéíóúÁÉÍÓÚ ]+$');
  if (value!.isEmpty || value.length <= lenght) {
    return 'Por favor, digite un valor valido';
  } else if (!regExp.hasMatch(value)) {
    return 'Por favor, digite un valor válido';
  } else {
    if (value.length > 64) {
      return 'Ha sobrepasado el numero de caracteres válido';
    } else {
      return null;
    }
  }
}

String? validateApellido(String? value) {
  RegExp regExp = RegExp(r'^[a-zA-ZZáéíóúñÁÉÍÓÚ ]+$');
  if (value!.isEmpty || value.length <= 2) {
    return 'Por favor, digite un apellido';
  } else if (!regExp.hasMatch(value)) {
    return 'Por favor, digite un apellido válido';
  } else {
    if (value.length > 64) {
      return 'Ha sobrepasado el numero de caracteres válido';
    } else {
      return null;
    }
  }
}

// static final RegExp nameRegExp = RegExp('[a-zA-Z]');
String? validateCodigo(String? value) {
  RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{6,12}$)');
  if (value!.isEmpty) {
    return 'Por favor, digite una codigo estudiantil';
  } else if (!regExp.hasMatch(value)) {
    return 'Por favor, digite un código válida';
  } else if (value.length > 10) {
    return 'Ha superado la cantidad minima de caracteres';
  } else {
    return null;
  }
}

//=====================
String? compareDates(DateTime selectedDate) {
  if (selectedDate == DateTime.now()) {
    return "Por favor digite una fecha";
  } else {
    return null;
  }
}
