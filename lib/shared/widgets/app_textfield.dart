import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyqx/core/constants/app_color.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;

  final TextStyle? textStyle;

  final InputDecoration? inputDecoration;

  final void Function(String)? onChanged;

  final void Function()? onEditingComplete;

  final void Function(String)? onSubmitted;

  final TextInputType? keyboardType;

  final bool obscureText;

  final String? errorMessage;

  final FocusNode? focusNode;

  final String? labelText;

  final String? prefixText;

  final TextEditingController? controller;

  final bool enabled;

  final bool isPassword;

  final List<TextInputFormatter>? inputFormatters;

  final bool enableInteractiveSelection;

  final double borderRadius;

  final double? hintSize;

  final Color fillColor;

  final List<Widget>? suffixIcons;

  final Widget? prefixIcon;

  final String? helperText;

  final bool isTransparentBorder;

  final Color? labelColor;

  final Color? hintColor;

  final Color? errorColor;

  final int? maxLines;

  final TextInputAction? action;

  final TextCapitalization textCapitalization;

  final Color? borderColor;

  final BoxConstraints? prefixIconConstraints;

  final int maxLength;

  final EdgeInsetsGeometry? contentPadding;

  final IconData? topIcon;

  final String? topName;

  final bool? hasButton;

  final bool? isLoading;

  final String? successMessage;

  final AutovalidateMode? autoValidateMode;

  final int? minLines;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const AppTextField(
      {super.key,
      this.hintText,
      this.suffixIcons,
      this.prefixIcon,
      this.onChanged,
      this.onEditingComplete,
      this.keyboardType,
      this.errorMessage,
      this.controller,
      this.focusNode,
      this.isLoading = false,
      this.prefixText,
      this.borderRadius = 8.0,
      this.enabled = true,
      this.inputFormatters,
      this.successMessage,
      this.maxLines,
      this.helperText,
      this.hintSize,
      this.isPassword = false,
      this.action = TextInputAction.done,
      this.enableInteractiveSelection = true,
      this.obscureText = false,
      this.fillColor = Colors.transparent,
      this.isTransparentBorder = false,
      this.textCapitalization = TextCapitalization.none,
      this.borderColor,
      this.hintColor,
      this.labelColor,
      this.onSubmitted,
      this.labelText,
      this.topIcon,
      this.hasButton = false,
      this.topName,
      this.errorColor,
      this.maxLength = TextField.noMaxLength,
      this.textStyle,
      this.inputDecoration,
      this.prefixIconConstraints,
      this.contentPadding,
      this.autoValidateMode,
      this.minLines,
      this.onSaved,
      this.validator});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final internalFocus = FocusNode();

  Widget? label;
  Widget? focusedLabel;
  Widget? unfocusedLabel;
  Color? labelTextColor;
  bool hasError = false;

  bool isPassword = false;

  @override
  void initState() {
    isPassword = widget.isPassword;
    setFocusListener();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setInitialLabelState();
    setLoaderIcon();
    super.didChangeDependencies();
  }

  setLoaderIcon() {
    if (widget.isLoading!) {
      (widget.suffixIcons ?? []).add(loaderIcon());

      setState(() {});
    }
  }

  tooglePasswordVisibility() {
    isPassword = !isPassword;
    setState(() {});
  }

  toogleHasError(bool val) {
    hasError = val;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      autovalidateMode:
          widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
      autocorrect: false,
      enableSuggestions: false,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enabled: widget.enabled,
      textCapitalization: widget.textCapitalization,
      controller: widget.controller,
      focusNode: widget.focusNode ?? internalFocus,
      cursorColor: AppColors.btnColor,
      obscureText: widget.isPassword ? isPassword : widget.obscureText,
      obscuringCharacter: '*',
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      textInputAction: widget.action ?? TextInputAction.done,
      onEditingComplete: widget.onEditingComplete,
      onSaved: widget.onSaved,
      validator: (val) {
        if (widget.validator == null) return null;
        final String? res = widget.validator!(val);
        if (res == null) {
          toogleHasError(false);
          return null;
        } else {
          toogleHasError(true);
          return res;
        }
      },
      style: TextStyle(
        color: widget.labelColor ??Colors.black,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
      decoration: widget.inputDecoration ??
          InputDecoration(
            counterText: "",
            prefixIconConstraints: widget.prefixIconConstraints ??
                const BoxConstraints(maxWidth: 60, maxHeight: 20),
            helperText: widget.helperText,
            labelText: widget.labelText,
            errorText:
                widget.errorMessage != null && widget.errorMessage!.isEmpty
                    ? null
                    : widget.errorMessage,
            contentPadding:
                widget.contentPadding ?? const EdgeInsets.only(left: 10),
            labelStyle: TextStyle(
              color: hasError
                  ? AppColors.errorColor
                  : widget.labelColor ?? const Color(0xFF8391a1),
              fontSize: 15,
              fontFamily: 'Ubernaist',
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFe8ecf4),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFe8ecf4),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 203, 205, 213),
                width: 1,
              ),
            ),
            filled: true,
            
            fillColor: const Color(0xFFf7f8f9),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              color: const Color(0xFF8391a1),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFFCFCFCF)),
                    onPressed: tooglePasswordVisibility,
                  )
                : widget.isLoading!
                    ? loaderIcon()
                    : widget.hasButton!
                        ? widget.suffixIcons != null &&
                                widget.suffixIcons!.isNotEmpty
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: widget.suffixIcons!
                                    .map(
                                      (e) => e,
                                    )
                                    .toList(),
                              )
                            : null
                        : null,
            prefixIcon: widget.prefixIcon,
            prefixText:
                widget.prefixText != null && widget.prefixText!.isNotEmpty
                    ? "${widget.prefixText!} "
                    : widget.prefixText,
            prefixStyle: widget.textStyle ?? const TextStyle(),
          ),
      onChanged: widget.onChanged,
    );
  }

  setFocusListener() {
    (widget.focusNode ?? internalFocus).addListener(() {
      if ((widget.focusNode ?? internalFocus).hasFocus) {
        label = focusedLabel;
        labelTextColor = AppColors.errorColor;
      } else {
        label = unfocusedLabel;
        labelTextColor = AppColors.errorColor;
      }

      setState(() {});
    });
  }

  Widget loaderIcon() => const Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: CircularProgressIndicator(),
      );

  setInitialLabelState() {
    if (widget.labelText != null && widget.labelText!.isEmpty) {
      return;
    } else {
      labelTextColor = AppColors.errorColor;
      focusedLabel = Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.purple),
        child: Text(widget.labelText ?? "",
            style: const TextStyle(color: AppColors.textFieldBorder)),
      );

      unfocusedLabel = Text(widget.labelText ?? "", style: const TextStyle());

      label = unfocusedLabel;

      setState(() {});
    }
  }
}
