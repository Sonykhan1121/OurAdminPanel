import 'package:admin_panel/features/service_features/views/service_list_item.dart';
import 'package:admin_panel/features/widgets/custom_page_header.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';

import '../../widgets/bottom_button_bar.dart';
import '../models/service_model.dart';
import '../view_models/service_view_model.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool editable = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: CustomPageHeader(text: "Services"),
      content: Consumer<ServiceViewModel>(
        builder: (context, serviceProvider, child) {
          return m.RefreshIndicator(
            onRefresh: () async {
              // await serviceProvider.refreshServices();
            },
            child: Container(
              color: Colors.white, // White background
              child: serviceProvider.isLoading
                  ? const Center(
                child: ProgressRing(),
              )
                  : serviceProvider.services.isEmpty
                  ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: const Text(
                    'No services available',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
                  : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: serviceProvider.services.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final service = serviceProvider.services[index];
                  return ServiceListItem(
                    service: service,
                    onEdit: () => _showEditDialog(context, service, serviceProvider),
                    onDelete: () => _showDeleteDialog(context, service, serviceProvider),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomBar: BottomButtonBar(
        isEditing: editable,
        isSaving: loading,
        onEdit: () {
          setState(() {
            editable = !editable;
          });
        },
        onCancel: () {
          setState(() {
            editable = !editable;
          });
        },
        onSave: () async {
          // print('Saving data...');
          // setState(() {
          //   loading = true;
          // });
          //
          // await SendToSupabase(...);
          //
          // setState(() {
          //   loading = false;
          // });
          // DSnackBar.success(title: "Data upload Successfully");
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, ServiceModel service, ServiceViewModel provider) {
    final titleController = TextEditingController(text: service.title ?? '');
    final countController = TextEditingController(text: service.count.toString());
    final descriptionController = TextEditingController(text: service.description ?? '');

    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Edit Service'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormBox(
                controller: titleController,
                placeholder: 'Service Title',
                decoration: WidgetStateProperty.all(
                  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              TextFormBox(
                controller: countController,
                placeholder: 'Count',
                keyboardType: TextInputType.number,
                decoration: WidgetStateProperty.all(
                  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 12),
              TextFormBox(
                controller: descriptionController,
                placeholder: 'Description',
                maxLines: 3,
                decoration: WidgetStateProperty.all(
                  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            child: const Text('Save'),
            onPressed: () async {
              final updatedService = ServiceModel(
                id: service.id,
                title: titleController.text,
                count: int.tryParse(countController.text) ?? 0,
                description: descriptionController.text,
              );

              // await provider.updateService(updatedService);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ServiceModel service, ServiceViewModel provider) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete "${service.title}"?'),
        actions: [
          Button(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: const Text('Delete'),
            onPressed: () async {
              // await provider.deleteService(service.id!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}