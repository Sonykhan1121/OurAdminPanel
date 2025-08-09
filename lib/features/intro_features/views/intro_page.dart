import 'dart:io';

import 'package:admin_panel/features/widgets/bottom_button_bar.dart';
import 'package:admin_panel/features/widgets/custom_dropdown.dart';
import 'package:admin_panel/utils/constants/app_texts.dart';
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
    DropdownItem(
      value: 'junior_software_dev',
      text: 'Junior Software Developer',
    ),
    DropdownItem(value: 'software_dev', text: 'Software Developer'),
    DropdownItem(
      value: 'senior_software_engineer',
      text: 'Senior Software Engineer',
    ),
    DropdownItem(
      value: 'lead_software_engineer',
      text: 'Lead Software Engineer',
    ),
    DropdownItem(value: 'frontend_dev', text: 'Frontend Developer'),
    DropdownItem(value: 'backend_dev', text: 'Backend Developer'),
    DropdownItem(value: 'fullstack_dev', text: 'Full-Stack Developer'),
    DropdownItem(value: 'mobile_dev', text: 'Mobile App Developer'),
    DropdownItem(value: 'game_dev', text: 'Game Developer'),
    DropdownItem(value: 'devops_engineer', text: 'DevOps Engineer'),
    DropdownItem(value: 'cloud_engineer', text: 'Cloud Engineer'),
    DropdownItem(value: 'data_analyst', text: 'Data Analyst'),
    DropdownItem(value: 'data_engineer', text: 'Data Engineer'),
    DropdownItem(value: 'data_scientist', text: 'Data Scientist'),
    DropdownItem(value: 'ml_engineer', text: 'Machine Learning Engineer'),
    DropdownItem(value: 'ai_research_engineer', text: 'AI Research Engineer'),
    DropdownItem(value: 'ui_ux_designer', text: 'UI/UX Designer'),
    DropdownItem(value: 'qa_engineer', text: 'QA Engineer'),
    DropdownItem(value: 'automation_tester', text: 'Automation Test Engineer'),
    DropdownItem(value: 'it_support', text: 'IT Support Specialist'),
    DropdownItem(value: 'network_admin', text: 'Network Administrator'),
    DropdownItem(value: 'sys_admin', text: 'Systems Administrator'),
    DropdownItem(
      value: 'cybersecurity_specialist',
      text: 'Cybersecurity Specialist',
    ),
    DropdownItem(value: 'security_engineer', text: 'Security Engineer'),
    DropdownItem(value: 'project_manager', text: 'Project Manager (IT)'),
    DropdownItem(value: 'product_manager', text: 'Product Manager (Tech)'),
    DropdownItem(value: 'cto', text: 'Chief Technology Officer (CTO)'),
    DropdownItem(value: 'cio', text: 'Chief Information Officer (CIO)'),
  ];
  File? selectedPDF;
  Map<String,String> socialLinks ={};
  bool loading = false;

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
                onImageSelected: (file) async {
                  try {
                    print('Selected image: ${file?.path}');
                    print('file : $file');
                    if (file == null) return;

                    String fileName = file.path.split('\\').last;
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

              ),
              SizedBox(height: 20),
              // Dropdown Demo
              CustomDropdown<String>(
                label: 'Select Designation',
                placeholder: 'Choose a designation...',
                items: itDesignations,
                value: 'software_dev',
                onChanged: (value) {
                  print('Selected: $value');
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
                onChanged: editable ? (value) => setState(() => longText = value) : null,
                editable: editable,
              ),
              const SizedBox(height: 20),


              CustomInputField(
                label: 'Back Picture Title',
                placeholder: 'Enter your back picture title',
                isPassword: false,
                prefixIcon: const Icon(FluentIcons.back, size: 18),
editable: editable,
              ),
              SizedBox(height: 20),
              CustomInputField(
                label: 'Front Picture Title',
                placeholder: 'Enter your Front picture title',
                isPassword: false,
                prefixIcon: const Icon(FluentIcons.padding_top, size: 18),
editable: editable,
              ),

              // PDF Picker Demo
              CustomPDFPicker(
                label: 'Resume/CV',
                isRequired: false,
                initialFile: selectedPDF,
                onFileSelected: editable?(file) => setState(() => selectedPDF = file):null,
              ),
              const SizedBox(height: 24),

              // Social Links Demo
              CustomSocialLinksInput(
                label: 'Social Media Links',
                isRequired: false,
                initialLinks: mapToSocialLinks(socialLinks, [
                  SocialPlatform('Facebook', m.Icons.facebook, 'https://facebook.com/'),
                  SocialPlatform('Instagram', m.Icons.camera_alt, 'https://instagram.com/'),
                  SocialPlatform('Twitter', m.Icons.alternate_email, 'https://twitter.com/'),
                  SocialPlatform('YouTube', m.Icons.play_circle_fill, 'https://youtube.com/'),
                  SocialPlatform('LinkedIn',m.Icons.business_center, 'https://linkedin.com/in/'),
                  SocialPlatform('TikTok', m.Icons.music_note, 'https://tiktok.com/@'),
                  SocialPlatform('Website', FluentIcons.globe, 'https://'),
                ]),
                editable: true, // or false
                onLinksChanged: (links) {
                  // Convert back to map if you want
                  socialLinks = {
                    for (var link in links) link.platform.name: link.url,
                  };
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
        onEdit: () {
          editable = !editable;
          setState(() {});
        },
        onCancel: () {
          editable = !editable;
          setState(() {});
        },
        onSave: () async {
          loading = true;
          if(mounted) {
            setState(() {

            });
          }
          await SendToSupabase(
            name: 'John Doe',
            designation: 'Software Developer',
            description: longText,
            backPictureTitle: 'Back Picture',
            frontPictureTitle: 'Front Picture',
            resume: selectedPDF,
            socialLinks: socialLinks,
          );

          loading = false;
          if(mounted) {
            setState(() {

            });
          }
        },
      ),
    );
  }

  Future<void> SendToSupabase(
      {required String name, required String designation, required String description, required String backPictureTitle, required String frontPictureTitle, File? resume, required Map<String,String> socialLinks}) async {
    
    

  }


  // convert map to List<SocialLink> for initialLinks
  List<SocialLink> mapToSocialLinks(Map<String, String> map, List<SocialPlatform> platforms) {
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
