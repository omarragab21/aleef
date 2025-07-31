import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;
  Color? color;
  Color? colorBackground;
  final bool showCameraIcon;

  ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.size = 100,
    this.onTap,
    this.showCameraIcon = true,
    this.color,
    this.colorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Profile Image Circle
          Container(
            width: size.w,
            height: size.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: ClipOval(
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultProfile();
                      },
                    )
                  : _buildDefaultProfile(),
            ),
          ),

          // Camera Icon Overlay
          if (showCameraIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: (size * 0.3).w,
                height: (size * 0.3).h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      colorBackground ??
                      const Color(
                        0xFFF8FFD9,
                      ), // Light yellow-green color (#F8FFD9)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'assets/images/svg/camera.svg',
                    color: color,
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
      child: Icon(Icons.person, size: (size * 0.5).w, color: Colors.grey[600]),
    );
  }
}
