import 'package:fluent_ui/fluent_ui.dart';

import '../models/service_model.dart';

class ServiceListItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ServiceListItem({
    super.key,
    required this.service,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Count: ${service.count}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (service.description != null && service.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    service.description!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon:  Icon(
                  FluentIcons.edit,
                  color: Colors.red,
                  size: 16,
                ),
                onPressed: onEdit,
              ),
              const SizedBox(width: 8),
              IconButton(
                icon:  Icon(
                  FluentIcons.delete,
                  color: Colors.red,
                  size: 16,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
