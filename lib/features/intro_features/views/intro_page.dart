import 'dart:convert';
import 'dart:io';

import 'package:admin_panel/features/intro_features/model/intro_model.dart';
import 'package:admin_panel/features/widgets/bottom_button_bar.dart';
import 'package:admin_panel/features/widgets/custom_dropdown.dart';
import 'package:admin_panel/features/widgets/custom_page_header.dart';
import 'package:admin_panel/utils/constants/app_texts.dart';
import 'package:admin_panel/utils/snackbar_toast/snak_bar.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;

import '../../../core/di/service_locator.dart';
import '../../../utils/constants/colors.dart';
import '../../auth_features/view_models/supabase_view_model.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_long_text_input.dart';
import '../../widgets/custom_pdf_picker.dart';
import '../../widgets/custom_social_links_input.dart';
import '../../widgets/profile_picker.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool editable = false;
  String? selectedCategory;
  String longText = 'Write message here...';
  final supabaseProvider = sl<SupabaseViewModel>();
  final List<DropdownItem<String>> itDesignations = [
    DropdownItem('Junior Software Developer'),
    DropdownItem('Software Developer'),
    DropdownItem('Senior Software Engineer'),
    DropdownItem('Lead Software Engineer'),
    DropdownItem('Frontend Developer'),
    DropdownItem('Backend Developer'),
    DropdownItem('Full-Stack Developer'),
    DropdownItem('Mobile App Developer'),
    DropdownItem('Game Developer'),
    DropdownItem('DevOps Engineer'),
    DropdownItem('Cloud Engineer'),
    DropdownItem('Data Analyst'),
    DropdownItem('Data Engineer'),
    DropdownItem('Data Scientist'),
    DropdownItem('Machine Learning Engineer'),
    DropdownItem('AI Research Engineer'),
    DropdownItem('UI/UX Designer'),
    DropdownItem('QA Engineer'),
    DropdownItem('Automation Test Engineer'),
    DropdownItem('IT Support Specialist'),
    DropdownItem('Network Administrator'),
    DropdownItem('Systems Administrator'),
    DropdownItem('Cybersecurity Specialist'),
    DropdownItem('Security Engineer'),
    DropdownItem('Project Manager (IT)'),
    DropdownItem('Product Manager (Tech)'),
    DropdownItem('Chief Technology Officer (CTO)'),
    DropdownItem('Chief Information Officer (CIO)'),
  ];

  File? selectedPDF;
  String? pdf_url;
  String? image_url;
  Map<String,String> socialLinks ={};
  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController backPictureTitleController = TextEditingController();
  final TextEditingController frontPictureTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
   String designation= 'Software Developer';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    m.WidgetsBinding.instance.addPostFrameCallback((_){
      // Load initial data from Supabase
      loadDataFromSupabase();
    });

  }
  Future<void> loadDataFromSupabase() async {
   Map<String, dynamic>? data = await supabaseProvider.getRowById(
      table: AppTexts.introTable,
      id: 1,
    );
    if (data != null) {
      print('Fetched data: ${jsonEncode(data)}');
      // Populate fields with fetched data
      nameController.text = data['name'] ?? '';
      image_url = data['imagePath'];
      designation = data['designation'] ?? 'Software Developer';
      descriptionController.text = data['description'] ?? '';
      longText = descriptionController.text;
      backPictureTitleController.text = data['pictureFontTitle'] ?? '';
      frontPictureTitleController.text = data['pictureBackTitle'] ?? '';
      pdf_url = data['pdfPath'] ?? '';

      socialLinks = Map<String, String>.from(data['socialLinks'] ?? {});
      print('Loaded social links: $socialLinks');
      if(mounted) setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: CustomPageHeader(text: 'Intro Page'),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfilePicker(
                size: 120,
                // initialImageUrl: 'assets/images/profile.png',
                 initialImageUrl: image_url,
                onImageSelected: (file) async {
                  try {
                    print('Selected image: ${file?.path}');
                    print('file : $file');
                    if (file == null) return;

                    String fileName = file.path.split('.').last;
                    final bytes = await file.readAsBytes();

                    print('Uploading file: $fileName, bytes length: ${bytes.length}');
                    await supabaseProvider.uploadFile(
                      bucket: AppTexts.bucketName,
                      path: "${AppTexts.imagePath}/$fileName",
                      fileBytes: bytes,
                    );
                    print('File uploaded to Supabase: $fileName ${supabaseProvider.uploadedFileUrl}');
                    print('supabaseProvider status: ${supabaseProvider.status}');
                    print('supabaseProvider error: ${supabaseProvider.errorMessage}');
                    if (supabaseProvider.uploadedFileUrl != null) {
                      image_url = supabaseProvider.uploadedFileUrl;

                    }
                  } catch (e, st) {
                    print('Error during upload: $e');
                    print(st);
                  }
                },

                borderColor: Colors.green,
                editable: editable,
              ),

              SizedBox(height: 20),
              CustomInputField(
                editable: editable,
                label: 'Name',
                placeholder: 'Enter your Name',
                isPassword: false,
                prefixIcon: const Icon(FluentIcons.title, size: 18),
                controller: nameController,

              ),
              SizedBox(height: 20),
              // Dropdown Demo
              CustomDropdown<String>(
                label: 'Select Designation',
                placeholder: 'Choose a designation...',
                items: itDesignations,
                value: designation,
                onChanged: (value,) {
                  designation = value!;
                  setState(() {

                  });
                },
                isRequired: true,
                errorText: null,

                // 🎨 Colors
                textColor: Colors.black,
                placeholderColor: Colors.grey,
                dropdownBgColor: Colors.white,
                borderColor: Colors.transparent,
                errorBorderColor: Colors.red,
                editable : editable,
              ),

              SizedBox(height: 20),
              // Long Text Input Demo
              CustomLongTextInput(
                label: 'Description',
                placeholder: 'Write a detailed description...',
                isRequired: true,
                maxLength: 500,
                value: longText,
                onChanged: editable ? (value,) => setState(() => longText = value) : null,
                editable: editable,
                controller: descriptionController,
              ),
              const SizedBox(height: 20),


              CustomInputField(
                label: 'Back Picture Title',
                placeholder: 'Enter your back picture title',
                isPassword: false,
                prefixIcon: const Icon(FluentIcons.back, size: 18),
editable: editable,
                controller: backPictureTitleController,
              ),
              SizedBox(height: 20),
              CustomInputField(
                label: 'Front Picture Title',
                placeholder: 'Enter your Front picture title',
                isPassword: false,
                prefixIcon: const Icon(FluentIcons.padding_top, size: 18),
editable: editable,
                controller: frontPictureTitleController,
              ),

              // PDF Picker Demo
              CustomPDFPicker(
                label: 'Resume/CV',
                isRequired: false,
                initialFile: selectedPDF,
                initialFilePath: pdf_url,
                onFileSelected: editable? (file) async {
                  print('Selected image: ${file?.path}');
                  print('file : $file');
                  if (file == null) return;

                  String fileName = file.path.split('\\').last;
                  final bytes = await file.readAsBytes();

                  print('Uploading file: $fileName, bytes length: ${bytes.length}');
                  await supabaseProvider.uploadFile(
                    bucket: AppTexts.bucketName,
                    path: "${AppTexts.pdfPath}/$fileName",
                    fileBytes: bytes,
                  );
                  if(supabaseProvider.uploadedFileUrl!=null)
                    {
                      pdf_url = supabaseProvider.uploadedFileUrl;
                      selectedPDF = file;
                     if(mounted) setState(() {});
                    }
                }:null, isEditable: editable,
              ),
              const SizedBox(height: 24),

              // Social Links Demo
              CustomSocialLinksInput(
                label: 'Social Media Links',
                isRequired: false,
                links: mapToSocialLinks(socialLinks, [
                  SocialPlatform('Facebook', m.Icons.facebook, 'https://facebook.com/'),
                  SocialPlatform('Instagram', m.Icons.camera_alt, 'https://instagram.com/'),
                  SocialPlatform('Twitter', m.Icons.alternate_email, 'https://twitter.com/'),
                  SocialPlatform('YouTube', m.Icons.play_circle_fill, 'https://youtube.com/'),
                  SocialPlatform('LinkedIn',m.Icons.business_center, 'https://linkedin.com/in/'),
                  SocialPlatform('TikTok', m.Icons.music_note, 'https://tiktok.com/@'),
                  SocialPlatform('Website', FluentIcons.globe, 'https://'),
                ]),
                editable: editable, // or false
                onLinksChanged: (links) {
                  // Convert back to map if you want
                  socialLinks = {
                    for (var link in links) link.platform.name: link.url,
                  };
                  print('Updated social links: $socialLinks');
                  setState(() {});
                },
              ),
              // DocumentPicker(
              //   label: 'Upload Resume',
              //   allowedExtensions: ['pdf', 'docx'],
              //   maxHeight: 150,
              //   showClearButton: false,
              //   customPreview: MyCustomDocumentPreview(),
              // )
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
          print('Saving data...');
          loading = true;
          if(mounted) {
            setState(() {

            });
          }
          await SendToSupabase(
            name: nameController.text,
            img_url: image_url??"",
            designation: designation,
            description: descriptionController.text,
            backPictureTitle: backPictureTitleController.text,
            frontPictureTitle: frontPictureTitleController.text,
            pdf_url: pdf_url??"",
            socialLinks: socialLinks,
          );


          loading = false;
          if(mounted) {
            setState(() {

            });
          }
          DSnackBar.success(title: "Data upload Successfully");
        },
      ),
    );
  }

  Future<void> SendToSupabase(
      {required String name,required String img_url, required String designation, required String description, required String backPictureTitle, required String frontPictureTitle, required String pdf_url, required Map<String,String> socialLinks}) async {
    print('Sending data to Supabase...');
    await supabaseProvider.insertData(
      table: AppTexts.introTable,
      data:IntroModel(
        id: 1,
        name: name,
        imagePath: img_url,
        designation: designation,
        description: description,
        pictureBackTitle: backPictureTitle,
        pictureFontTitle: frontPictureTitle,
        pdfPath: pdf_url,
        socialLinks: socialLinks,
      ).toJson(),
    );
    print('supabaseProvider status: ${supabaseProvider.status}');
    print('supabaseProvider error: ${supabaseProvider.errorMessage}');



  }


  // convert map to List<SocialLink> for initialLinks
  List<SocialLink> mapToSocialLinks(Map<String, String> map, List<SocialPlatform> platforms) {
    print('Converting map to SocialLinks: $map');
    return map.entries.map((e) {
      final platform = platforms.firstWhere(
            (p) => e.key.toLowerCase() == p.name.toLowerCase(),
        orElse: () => platforms.last,
      );
      return SocialLink(
        platform: platform,
        url: e.value,
        controller: TextEditingController(text: e.value),
      );
    }).toList();
  }
}
