import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

/// A profile image widget that supports image picking from camera or gallery.
///
/// Features:
/// - Displays profile image from URL or local file
/// - Allows picking images from camera or gallery
/// - Shows camera icon overlay for image selection
/// - Supports custom styling and callbacks
///
/// Usage:
/// ```dart
/// ProfileImageWidget(
///   size: 120,
///   onImagePicked: (File? imageFile) {
///     // Handle the picked image
///     if (imageFile != null) {
///       // Upload to server or store locally
///     }
///   },
/// )
/// ```
class ProfileImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;
  final Function(File?)? onImagePicked;
  Color? color;
  Color? colorBackground;
  final bool showCameraIcon;

  ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.size = 100,
    this.onTap,
    this.onImagePicked,
    this.showCameraIcon = true,
    this.color,
    this.colorBackground,
  });

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        // Call the callback if provided
        if (widget.onImagePicked != null) {
          widget.onImagePicked!(_selectedImage);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_image_source'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('camera'.tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('gallery'.tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _showImageSourceDialog,
      child: Stack(
        children: [
          // Profile Image Circle
          Container(
            width: widget.size.w,
            height: widget.size.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: ClipOval(
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultProfile();
                      },
                    )
                  : widget.imageUrl != null
                  ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultProfile();
                      },
                    )
                  : _buildDefaultProfile(),
            ),
          ),

          // Camera Icon Overlay
          if (widget.showCameraIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: (widget.size * 0.3).w,
                height: (widget.size * 0.3).h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.colorBackground ??
                      const Color(
                        0xFFF8FFD9,
                      ), // Light yellow-green color (#F8FFD9)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'assets/images/svg/camera.svg',
                    color: widget.color,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDefaultProfile() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(
        Icons.person,
        size: (widget.size * 0.5).w,
        color: Colors.grey[600],
      ),
    );
  }
}
