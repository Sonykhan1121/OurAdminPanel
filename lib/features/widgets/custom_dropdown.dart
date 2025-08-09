import 'package:fluent_ui/fluent_ui.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final String placeholder;
  final List<DropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final String? errorText;
  final Color? textColor;
  final Color? placeholderColor;
  final Color? dropdownBgColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final bool editable;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.items,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.errorText,
    this.textColor,
    this.placeholderColor,
    this.dropdownBgColor,
    this.borderColor,
    this.errorBorderColor,
    required this.editable,
  }) : super(key: key);

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    // assign runtime defaults here (no compile-time requirement)
    final Color textColor = widget.textColor ?? Colors.black;
    final Color placeholderColor = widget.placeholderColor ?? Colors.grey;
    final Color dropdownBgColor = widget.dropdownBgColor ?? Colors.white;
    final Color borderColor = widget.borderColor ?? Colors.black;
    final Color errorBorderColor = widget.errorBorderColor ?? Colors.red;

    // Outer box decoration controlling the visible area (border/background)
    final decoration = BoxDecoration(
      color: dropdownBgColor,
      border: Border.all(
        color: widget.errorText != null ? errorBorderColor : borderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            children:
                widget.isRequired
                    ? [TextSpan(text: ' *', style: TextStyle(color: textColor))]
                    : [],
          ),
        ),
        const SizedBox(height: 8),

        // Box with border & rounded corners
        Container(
          width: double.infinity,
          decoration: decoration,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ComboBox<T>(
            // displayed placeholder
            placeholder: Text(
              widget.placeholder,
              style: TextStyle(color: placeholderColor, fontSize: 14),
            ),

            // selected value
            value: widget.value,

            // items - give explicit text color per item
            items:
                widget.items
                    .map(
                      (item) => ComboBoxItem<T>(
                        value: item.value,
                        child: Text(
                          item.text,
                          style: TextStyle(color: textColor, fontSize: 14),
                        ),
                      ),
                    )
                    .toList(),

            onChanged: widget.editable?widget.onChanged:null,

            // text style for the selected text shown in the closed ComboBox
            style: TextStyle(fontSize: 14, color: textColor),

            // optional visual tweaks:

            isExpanded: true,
          ),
        ),

        // error text
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText!,
            style: TextStyle(color: errorBorderColor, fontSize: 12),
          ),
        ],
      ],
    );
  }
}

class DropdownItem<T> {
  final T value;
  final String text;

  DropdownItem({required this.value, required this.text});
}
