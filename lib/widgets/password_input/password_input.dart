import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String title;
  final String placeholder;
  final void Function(String? value)? onFieldSubmitted;
  final void Function(String? value)? onValid;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsets? padding;
  final InputValidatorRule? passwordRule;
  final TextEditingController? textController;
  final bool showEmptySpaceForErrorMessage;
  final bool autocorrect;
  final bool enabled;

  const PasswordInput({
    super.key,
    this.title = '',
    this.placeholder = '',
    this.titleStyle,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.padding,
    this.passwordRule,
    this.onValid,
    this.onFieldSubmitted,
    this.textController,
    this.showEmptySpaceForErrorMessage = true,
    this.autocorrect = true,
    this.enabled = true,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late TextEditingController _controller;
  var _errorMessage = '';
  var _touched = false;
  var _isVisibility = false;
  final _focusNode = FocusNode();
  final _validatorRules = [
    InputValidatorRule.require(errorMessage: 'Password is required'),
  ];

  @override
  void initState() {
    super.initState();

    _controller = widget.textController ?? TextEditingController();
    _focusNode.addListener(_onChangeFocus);

    if (widget.passwordRule != null) {
      _validatorRules.add(widget.passwordRule!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onChangeFocus)
      ..dispose();

    super.dispose();
  }

  void _onChangeFocus() {
    if (!_focusNode.hasFocus) {
      _touched = true;
      _onChanged(_controller.text);
    }

    setState(() {});
  }

  void _onChanged(String value, {bool submit = false}) {
    _errorMessage = _validatorRules.validate(value);

    setState(() {});

    final validData = _errorMessage.isEmpty ? value : null;
    if (widget.onValid != null) {
      widget.onValid!(validData);
    }

    if (submit) {
      if (widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted!(validData);
      }
    }
  }

  Widget _buildErrorMessage() {
    if (!widget.showEmptySpaceForErrorMessage && _errorMessage.isEmpty) {
      return const SizedBox();
    }

    return widget.errorTextStyle != null
        ? XText.labelSmall(
            _touched ? _errorMessage : '',
            style: widget.errorTextStyle!,
          )
        : XText.labelSmall(
            _touched ? _errorMessage : '',
          ).customWith(
            context,
            color: context.errorColor,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XText.headlineSmall(
          widget.title,
          style: widget.titleStyle,
        ),
        SizedBox(
          height: widget.enabledBorder != null ? 8 : 0,
        ),
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: widget.hintStyle,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            contentPadding: widget.padding ?? const EdgeInsets.only(bottom: 6),
            isCollapsed: true,
            suffix: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisibility = !_isVisibility;
                });
              },
              child: Icon(
                _isVisibility ? Icons.visibility_off : Icons.visibility,
                color: context.primaryColor,
                size: 20,
              ),
            ),
          ),
          style: widget.textStyle ?? context.labelMedium,
          keyboardType: TextInputType.text,
          onChanged: _onChanged,
          onFieldSubmitted: (value) => _onChanged(value, submit: true),
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
          obscureText: !_isVisibility,
        ),
        _buildErrorMessage(),
      ],
    );
  }
}
