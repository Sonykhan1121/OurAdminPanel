import 'package:admin_panel/features/widgets/custom_page_header.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../widgets/bottom_button_bar.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  bool editable = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: CustomPageHeader(text: "Experience  Count Page"),
        content: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

              ],
            ),
          ),
        ),
        bottomBar: BottomButtonBar(
          isEditing: editable,
          isSaving: loading,
          onEdit: () {
            editable = !editable;
            setState(() {});
          },
          onCancel: () {
            editable = !editable;
            setState(() {});
          },
          onSave: () async {
            // print('Saving data...');
            // loading = true;
            // if(mounted) {
            //   setState(() {
            //
            //   });
            // }
            // await SendToSupabase(
            //   name: nameController.text,
            //   img_url: image_url??"",
            //   designation: designation,
            //   description: descriptionController.text,
            //   backPictureTitle: backPictureTitleController.text,
            //   frontPictureTitle: frontPictureTitleController.text,
            //   pdf_url: pdf_url??"",
            //   socialLinks: socialLinks,
            // );
            //
            //
            // loading = false;
            // if(mounted) {
            //   setState(() {
            //
            //   });
            // }
            // DSnackBar.success(title: "Data upload Successfully");
          },
        )
    );
  }
}
