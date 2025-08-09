import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:admin_panel/utils/constants/colors.dart';

class CustomSocialLinksInput extends StatefulWidget {
  final String label;
  final List<SocialLink>? initialLinks;
  final Function(List<SocialLink>)? onLinksChanged;
  final bool isRequired;
  final String? errorText;
  final bool editable; // added editable flag

  const CustomSocialLinksInput({
    Key? key,
    required this.label,
    this.initialLinks,
    this.onLinksChanged,
    this.isRequired = false,
    this.errorText,
    this.editable = true, // default true, allow editing by default
  }) : super(key: key);

  @override
  State<CustomSocialLinksInput> createState() => _CustomSocialLinksInputState();
}

class _CustomSocialLinksInputState extends State<CustomSocialLinksInput> {
  late List<SocialLink> _links;

  final List<SocialPlatform> _platforms = [
    SocialPlatform('Facebook', m.Icons.facebook, 'https://facebook.com/'),
    SocialPlatform('Instagram', m.Icons.camera_alt, 'https://instagram.com/'),
    SocialPlatform('Twitter', m.Icons.alternate_email, 'https://twitter.com/'),
    SocialPlatform('YouTube', m.Icons.play_circle_fill, 'https://youtube.com/'),
    SocialPlatform('LinkedIn', m.Icons.business_center, 'https://linkedin.com/in/'),
    SocialPlatform('TikTok', m.Icons.music_note, 'https://tiktok.com/@'),
    SocialPlatform('Website', FluentIcons.globe, 'https://'),
  ];

  @override
  void initState() {
    super.initState();
    _links = widget.initialLinks != null
        ? widget.initialLinks!
        .map((link) => SocialLink(
      platform: link.platform,
      url: link.url,
      controller: TextEditingController(text: link.url),
    ))
        .toList()
        : [];
  }

  void _addLink() {
    if (!widget.editable) return;
    setState(() {
      _links.add(SocialLink(
        platform: _platforms.first,
        url: '',
        controller: TextEditingController(),
      ));
    });
    _notifyChange();
  }

  void _removeLink(int index) {
    if (!widget.editable) return;
    setState(() {
      _links[index].controller.dispose();
      _links.removeAt(index);
    });
    _notifyChange();
  }

  void _updateLink(int index, SocialPlatform? platform, String url) {
    if (!widget.editable) return;
    setState(() {
      if (platform != null) {
        _links[index].platform = platform;
      }
      _links[index].url = url;
      // Also update controller text if it differs to keep sync
      if (_links[index].controller.text != url) {
        _links[index].controller.text = url;
      }
    });
    _notifyChange();
  }

  void _notifyChange() {
    widget.onLinksChanged?.call(_links);
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
                text: widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: DColors.black,
                ),
                children: widget.isRequired
                    ? [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: DColors.error),
                  ),
                ]
                    : [],
              ),
            ),
            if (widget.editable)
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
        if (_links.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: DColors.white,
              border: Border.all(
                color: widget.errorText != null
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
          )
        else
          Column(
            children: _links.asMap().entries.map((entry) {
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
                          width: 120,
                          child: ComboBox<SocialPlatform>(
                            value: link.platform,
                            items: _platforms
                                .map(
                                  (platform) => ComboBoxItem<SocialPlatform>(
                                value: platform,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(platform.icon, size: 16),
                                    const SizedBox(width: 8),
                                    Text(platform.name),
                                  ],
                                ),
                              ),
                            )
                                .toList(),
                            onChanged: widget.editable
                                ? (platform) =>
                                _updateLink(index, platform, link.url)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextBox(
                            controller: link.controller,
                            placeholder: '${link.platform.baseUrl}username',
                            onChanged: widget.editable
                                ? (value) => _updateLink(index, null, value)
                                : null,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            placeholderStyle: TextStyle(
                              color: DColors.textSecondary,
                              fontSize: 14,
                            ),
                            enabled: widget.editable,
                          ),
                        ),
                        if (widget.editable) ...[
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
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: DColors.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    for (var link in _links) {
      link.controller.dispose();
    }
    super.dispose();
  }
}

class SocialPlatform {
  final String name;
  final IconData icon;
  final String baseUrl;

  SocialPlatform(this.name, this.icon, this.baseUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SocialPlatform &&
              runtimeType == other.runtimeType &&
              name == other.name;

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
