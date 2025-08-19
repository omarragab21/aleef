import 'package:aleef/shared/assets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'track_your_order'.tr(),
          style: const TextStyle(
            color: Color(0xFF424242),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Order Summary Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F1E9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF6D9773), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'expected_arrival_date'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'tracking_number'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '10 يونيو 2025',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '#747364',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Order Tracking Progress Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F1E9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF6D9773), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'track_order'.tr(),
                      style: const TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView(
                      shrinkWrap: true,

                      children: [
                        _buildTimelineTile(
                          title: 'تم تقديم الطلب',
                          subtitle: '5 يونيو2025 – 4:12م',
                          isCompleted: true,
                          isFirst: true,
                          isLast: false,
                        ),
                        _buildTimelineTile(
                          title: 'جاري التجهيز',
                          subtitle: '5 يونيو2025 – 4:12م',
                          isCompleted: true,
                          isFirst: false,
                          isLast: false,
                        ),
                        _buildTimelineTile(
                          title: 'في الطريق إليك',
                          subtitle: '',
                          isCompleted: false,
                          isFirst: false,
                          isLast: false,
                        ),
                        _buildTimelineTile(
                          title: 'جاري التوصيل',
                          subtitle: '',
                          isCompleted: false,
                          isFirst: false,
                          isLast: true,
                        ),
                      ],
                    ),
                    // Pro  fessional Timeline Widget (Right Aligned)
                  ],
                ),
              ),

              // Decorative Paw Print
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(
                  'assets/images/svg/dog_tracks.svg',
                  height: 200,
                  width: 200,
                ),
              ),

              const SizedBox(height: 20),

              // Return to Home Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'back_to_home'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineTile({
    required String title,
    required String subtitle,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return TimelineTile(
      nodeAlign: TimelineNodeAlign.start,

      contents: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            if (subtitle.isEmpty) ...[const SizedBox(height: 18)],
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 0),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: const Color(0xFF757575),
                ),
              ),
            ],
          ],
        ),
      ),
      node: TimelineNode(
        indicator: isCompleted
            ? Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              )
            : Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primary, width: 2),
                ),
              ),
        startConnector: isFirst
            ? null
            : const SolidLineConnector(
                color: AppColor.primary,
                thickness: 2,
                space: 10,
              ),
        endConnector: isLast
            ? null
            : const SolidLineConnector(
                color: AppColor.primary,
                thickness: 2,
                space: 10,
              ),
      ),
    );
  }
}
