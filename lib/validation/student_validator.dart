mixin class stuValidationMixin {
  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return "The name must be at least two characters long";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return "The last name must be at least two characters long";
    }
    return null;
  }

  String? validateGradePoint(String? value) {
    if (value == null || value.isEmpty) {
      return "Please, enter a value.";
    } else if (int.tryParse(value) == null) {
      return "Please enter a valid number.";
    } else if (int?.tryParse(value)! < 0 || int.tryParse(value)! > 100) {
      return "The grade point must be at between 0-100.";
    }

    return null;
  }
}
