import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/constants/colors.dart';
import 'bordered_red_button.dart';
import 'filled_red_button.dart';

class BottomButtonBar extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isSaving;

  const BottomButtonBar({
    super.key,
    required this.isEditing,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
    this.isSaving = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left-aligned Edit button (when not editing)
          if (!isEditing)
            Expanded(
              child: BorderedRedButton(
                text: 'Edit',
                onPressed: onEdit,
                borderRadius: 4,
              ),
            ),



          // Right-aligned action buttons
          if(isEditing)Flexible(
            child: Row(
              children: [
                if (isEditing) ...[
                  Expanded(
                    child: BorderedRedButton(
                      text: 'Cancel',
                      onPressed: onCancel,
                      borderRadius: 4,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledRedButton(
                      text: 'Save Changes',
                      onPressed: onSave,
                      borderRadius: 4,
                      isLoading: isSaving,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

