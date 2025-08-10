import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:admin_panel/utils/constants/colors.dart';

class CustomSocialLinksInput extends StatelessWidget {
  final String label;
  final List<SocialLink> links;
  final Function(List<SocialLink>)? onLinksChanged;
  final bool isRequired;
  final String? errorText;
  final bool editable;

  CustomSocialLinksInput({
    Key? key,
    required this.label,
    required this.links,
    this.onLinksChanged,
    this.isRequired = false,
    this.errorText,
    this.editable = true,
  }) : super(key: key);

  final List<SocialPlatform> _platforms = const [
    SocialPlatform('Facebook', m.Icons.facebook, 'https://facebook.com/'),
    SocialPlatform('Instagram', m.Icons.camera_alt, 'https://instagram.com/'),
    SocialPlatform('Twitter', m.Icons.alternate_email, 'https://twitter.com/'),
    SocialPlatform('YouTube', m.Icons.play_circle_fill, 'https://youtube.com/'),
    SocialPlatform('LinkedIn', m.Icons.business_center, 'https://linkedin.com/in/'),
    SocialPlatform('TikTok', m.Icons.music_note, 'https://tiktok.com/@'),
    SocialPlatform('Website', FluentIcons.globe, 'https://'),
  ];

  void _addLink() {
    if (!editable) return;

    // Find first platform not already used
    final existingPlatforms = links.map((l) => l.platform).toSet();
    final availablePlatform = _platforms.firstWhere(
          (p) => !existingPlatforms.contains(p),
      orElse: () => _platforms.first, // fallback if all used
    );

    // Only add if there's a free platform left
    if (!existingPlatforms.contains(availablePlatform)) {
      final newLink = SocialLink(
        platform: availablePlatform,
        url: '',
        controller: TextEditingController(),
      );

      print('Adding new link: $newLink');
      onLinksChanged?.call([...links, newLink]);
    } else {
      print('All platforms already added.');
    }
  }


  void _removeLink(int index) {
    if (!editable) return;
    final updated = List<SocialLink>.from(links);
    updated[index].controller.dispose();
    updated.removeAt(index);
    onLinksChanged?.call(updated);
  }

  void _updateLink(int index, {SocialPlatform? platform, String? url}) {
    if (!editable) return;
    final updated = List<SocialLink>.from(links);
    if (platform != null) updated[index].platform = platform;
    if (url != null) {
      updated[index].url = url;
      if (updated[index].controller.text != url) {
        updated[index].controller.text = url;
      }
    }
    onLinksChanged?.call(updated);
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url) != null && url.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + Add Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: DColors.black,
                ),
                children: isRequired
                    ? [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: DColors.error),
                  ),
                ]
                    : [],
              ),
            ),
            if (editable)
              Button(
                onPressed: _addLink,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.add, size: 14),
                    const SizedBox(width: 4),
                    Text('Add Link', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (links.isEmpty)
          _buildEmptyState()
        else
          Column(
            children: links.asMap().entries.map((entry) {
              int index = entry.key;
              SocialLink link = entry.value;
              bool hasError = link.url.isNotEmpty && !_isValidUrl(link.url);

              return Container(
                key: ValueKey(link.controller),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DColors.white,
                  border: Border.all(
                    color: hasError
                        ? DColors.error
                        : DColors.black.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: ComboBox<SocialPlatform>(
                            value: link.platform,
                            style: TextStyle(fontSize: 11),
                            items: _platforms
                                .map(
                                  (platform) => ComboBoxItem<SocialPlatform>(
                                value: platform,
                                child: SizedBox(
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Icon(platform.icon, size: 16),
                                      const SizedBox(width: 8),
                                      Text(platform.name, style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            onChanged: editable
                                ? (platform) => _updateLink(index, platform: platform)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextBox(
                            controller: link.controller,
                            placeholder: '${link.platform.baseUrl}username',
                            onChanged: editable
                                ? (value) => _updateLink(index, url: value)
                                : null,
                            style: const TextStyle(fontSize: 12),
                            placeholderStyle: TextStyle(
                              color: DColors.textSecondary,
                              fontSize: 12,
                            ),
                            enabled: editable,
                          ),
                        ),
                        if (editable) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                              FluentIcons.delete,
                              color: DColors.textSecondary,
                              size: 16,
                            ),
                            onPressed: () => _removeLink(index),
                          ),
                        ],
                      ],
                    ),
                    if (hasError) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please enter a valid URL',
                          style: TextStyle(
                            color: DColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: TextStyle(
              color: DColors.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DColors.white,
        border: Border.all(
          color: errorText != null
              ? DColors.error
              : DColors.black.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Icon(
            FluentIcons.link,
            size: 32,
            color: DColors.textSecondary,
          ),
          const SizedBox(height: 8),
          Text(
            'No social links added yet',
            style: TextStyle(
              color: DColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Click "Add Link" to start adding your social media links',
            style: TextStyle(
              color: DColors.textSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SocialPlatform {
  final String name;
  final IconData icon;
  final String baseUrl;

  const SocialPlatform(this.name, this.icon, this.baseUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SocialPlatform && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class SocialLink {
  SocialPlatform platform;
  String url;
  final TextEditingController controller;

  SocialLink({
    required this.platform,
    required this.url,
    required this.controller,
  });
}
