import 'package:admin_panel/features/widgets/bordered_red_button.dart';
import 'package:admin_panel/features/widgets/bottom_button_bar.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../utils/constants/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/document_picker.dart';
import '../../widgets/enhanced_text_box.dart';
import '../../widgets/profile_picker.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool editable = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Intro Page',
          style: TextStyle(color: DColors.secondary, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfilePicker(
                size: 120,
                initialImageUrl: 'assets/images/profile.png',
                onImageSelected: (file) => print('Selected: ${file?.path}'),
                borderColor: Colors.green,
                editable: true,
              ),
               SizedBox(height: 20),

              CustomInputField(
                label: 'Password',
                placeholder: 'Enter your password',
                isPassword: true,
                prefixIcon: const Icon(FluentIcons.lock, size: 18),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              // DocumentPicker(
              //   label: 'Upload Resume',
              //   allowedExtensions: ['pdf', 'docx'],
              //   maxHeight: 150,
              //   showClearButton: false,
              //   customPreview: MyCustomDocumentPreview(),
              // )
            ]
          ),
        ),
      ),
      bottomBar: BottomButtonBar(
        isEditing: editable,
        onEdit: () {
          editable = !editable;
          setState(() {});
        },
        onCancel: () {
          editable = !editable;
          setState(() {});
        },
        onSave: () {},
      ),
    );
  }
}
