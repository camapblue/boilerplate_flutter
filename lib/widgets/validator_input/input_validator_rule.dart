class InputValidatorRule {
  final String errorMessage;
  final bool Function(String? input) validator;

  InputValidatorRule({
    required this.errorMessage,
    required this.validator,
  });

  factory InputValidatorRule.require({required String errorMessage}) {
    return InputValidatorRule(
      errorMessage: errorMessage,
      validator: (input) => input != null && input.isNotEmpty,
    );
  }
}

extension InputValidatorRules on List<InputValidatorRule> {
  String validate(String value) {
    for (final rule in this) {
      if (!rule.validator(value)) {
        return rule.errorMessage;
      }
    }

    return '';
  }
}
