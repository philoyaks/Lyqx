// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

/// # AppButton Widget
///
/// `AppButton` is a versatile Flutter widget for creating customizable buttons with different styles.
///
/// ## Properties:
/// - `onPressed`: A callback function to execute when the button is pressed.
/// - `label`: The text label displayed on the button.
/// - `labelColor`: The color of the button label text.
/// - `bgColor`: The background color of the button.
/// - `isLoading`: Set to `true` to display a loading indicator within the button.
/// - `leadingIcon`: An optional icon or widget to be displayed before the button label.
/// - `trailingIcon`: An optional icon or widget to be displayed after the button label.
///
/// ## Constructors:
/// - `AppButton`: Creates a default elevated button with customizable properties.
/// - `AppButton.text`: Creates a text button with customizable properties.
/// - `AppButton.outlined`: Creates an outlined button with customizable properties.
///
/// ## Usage:
/// ```dart
/// AppButton(
///   label: 'Submit',
///   onPressed: () {
///     // Handle button press
///   },
///   isLoading: false,
///   leadingIcon: Icon(Icons.send),
///   trailingIcon: Icon(Icons.cancel),
/// )
/// ```
///
/// ## Examples:
/// - To create a text button: `AppButton.text(label: 'Cancel', onPressed: () { /* Handle cancel */ })`
/// - To create an outlined button: `AppButton.outlined(label: 'Outline', onPressed: () { /* Handle outline */ })`
///
/// ## Notes:
/// - The appearance of the button adapts based on the specified properties.
/// - Icons automatically adapt to the button theme and color.
/// - The `isLoading` property displays a loading indicator when set to `true`.
///
/// ## Additional Widgets:
/// - `LoadingWidget`: A simple loading indicator widget.
/// - `ColoredWidget`: Automatically adapts the color of its child based on the button theme.
///
/// Feel free to customize the button appearance and behavior as needed.
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? labelColor;
  final Color? bgColor;
  final Color? disabledBgColor;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  bool _isOutlinedButton = false;

  bool _isTextButton = false;
  TextStyle? textColor;
  double? borderRadius;

  AppButton({
    super.key,
    this.label = '',
    this.onPressed,
    this.labelColor,
    this.bgColor,
    this.disabledBgColor,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.borderRadius,
  });

  AppButton.text({
    super.key,
    this.onPressed,
    this.label = '',
    this.labelColor,
    this.disabledBgColor,
    this.bgColor,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.textColor,
    this.borderRadius,
  }) : _isTextButton = true;

  AppButton.outlined({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.label = '',
    this.labelColor,
    this.bgColor,
    this.disabledBgColor,
    this.leadingIcon,
    this.trailingIcon,
    this.textColor,
    this.borderRadius,
  }) : _isOutlinedButton = true;

  @override
  Widget build(BuildContext context) {
    final bool hasLeadingIcon = leadingIcon != null;
    final bool hasTrailingIcon = trailingIcon != null;

    return _isOutlinedButton
        ? OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: bgColor,
              side: isLoading
                  ? const BorderSide(
                      color: Color(0xFF1F2223),
                      width: 1,
                      style: BorderStyle.solid)
                  : BorderSide(
                      color: labelColor ?? const Color(0xFF1F2223),
                      width: 1,
                      style: BorderStyle.solid),
            ),
            child: isLoading
                ? const LoadingWidget()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasLeadingIcon) ...[
                        ColoredWidget(
                          color: Colors.transparent,
                          isOutlinedButton: true,
                          isEnabled: onPressed != null,
                          child: leadingIcon!,
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: onPressed == null
                            ? const TextStyle(
                                color: Color(0xFFF8F6F6),
                                fontSize: 16,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              )
                            : TextStyle(
                                color: labelColor ?? const Color(0xFFF8F6F6),
                                fontSize: 16,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              ),
                      ),
                      if (hasTrailingIcon) ...[
                        const SizedBox(
                          width: 8,
                        ),
                        ColoredWidget(
                          color: Colors.transparent,
                          isOutlinedButton: true,
                          isEnabled: onPressed != null,
                          child: trailingIcon!,
                        ),
                      ],
                    ],
                  ))
        : _isTextButton
            ? TextButton(
                onPressed: isLoading ? null : onPressed,
                child: isLoading
                    ? const LoadingWidget()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasLeadingIcon) ...[
                            ColoredWidget(
                              color: Colors.transparent,
                              isElevatedButton: false,
                              isEnabled: onPressed != null,
                              child: leadingIcon!,
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                          Text(
                            label.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFFCFCFC),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (hasTrailingIcon) ...[
                            const SizedBox(
                              width: 8,
                            ),
                            ColoredWidget(
                              color: Colors.transparent,
                              isElevatedButton: false,
                              isEnabled: onPressed != null,
                              child: trailingIcon!,
                            ),
                          ],
                        ],
                      ))
            : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    disabledBackgroundColor:
                        isLoading ? const Color(0xFF1F2223) : disabledBgColor,
                    shape: borderRadius != null
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius!),
                          )
                        : null,

                    // shadowColor: null,

                    // shadowColor:
                    //     onPressed == null ? null : const Color(0xFFCDEF41),
                    elevation: 3),
                child: isLoading
                    ? const LoadingWidget()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasLeadingIcon) ...[
                            ColoredWidget(
                              color: Colors.transparent,
                              isElevatedButton: true,
                              isEnabled: onPressed != null,
                              child: leadingIcon!,
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: labelColor ?? const Color(0xFFFCFCFC),
                              fontSize: 16,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (hasTrailingIcon) ...[
                            const SizedBox(
                              width: 8,
                            ),
                            ColoredWidget(
                              color: Colors.transparent,
                              isElevatedButton: true,
                              isEnabled: onPressed != null,
                              child: trailingIcon!,
                            ),
                          ],
                        ],
                      ));
  }
}

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: (height ?? 30),
        width: (width ?? 30),
        child: const CircularProgressIndicator());
  }
}

/// # ColoredWidget Widget
///
/// `ColoredWidget` is used to automatically adapt the color of its child based on the button theme.
///
/// ## Notes:
/// - This widget automatically adapts the color based on the button theme and state.
/// - Works for icons, SVGs, images, or any widget assigned to it.
class ColoredWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isElevatedButton;
  final bool isOutlinedButton;
  final bool isEnabled;

  const ColoredWidget(
      {super.key,
      required this.child,
      required this.color,
      this.isElevatedButton = false,
      this.isOutlinedButton = false,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isElevatedButton ? const Color(0xFF1F2223) : color,
        BlendMode.srcIn,
      ),
      child: child,
    );
  }
}
