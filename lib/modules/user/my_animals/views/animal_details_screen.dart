import 'package:aleef/shared/assets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimalDetailsScreen extends StatefulWidget {
  const AnimalDetailsScreen({super.key});

  @override
  State<AnimalDetailsScreen> createState() => _AnimalDetailsScreenState();
}

class _AnimalDetailsScreenState extends State<AnimalDetailsScreen> {
  int _selectedIndex = 2; // My Pets is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation with back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_ios, color: AppColor.primary, size: 20),
                ],
              ),
            ),

            // Pet Profile Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Pet Image
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF6F1E9), // Light beige
                          border: Border.all(color: AppColor.stroke1, width: 1),
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F5DC),
                            ),
                            child: const Icon(
                              Icons.pets,
                              size: 60,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Pet Name with Paw Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لولو',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.pets, color: AppColor.primary, size: 24),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Pet Information Card
                    _buildInfoCard([
                      'السلالة : قطة شيرازي',
                      'اللون: أبيض × بيج',
                      'تاريخ الميلاد: 12 أبريل 2021',
                      'مكان المعيشة: في البيت',
                    ], EdgeInsets.symmetric(horizontal: 30)),

                    const SizedBox(height: 24),

                    // Vaccinations Section
                    _buildSectionHeader(
                      'التطعيمات',
                      'assets/images/svg/vacation.svg',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 358,

                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F1E9),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFFE0E0E0), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            [
                              'تطعيم شامل - 10 يناير 2025',
                              'ضد الديدان - 5 مايو 2025',
                              'ضد السعار - 1 مارس 2025',
                            ].length,
                            (index) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                    top: 2,
                                    bottom: index == 2 ? 10 : 0,
                                  ),
                                  child: Text(
                                    [
                                      'تطعيم شامل - 10 يناير 2025',
                                      'ضد الديدان - 5 مايو 2025',
                                      'ضد السعار - 1 مارس 2025',
                                    ][index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (index <
                                    [
                                          'تطعيم شامل - 10 يناير 2025',
                                          'ضد الديدان - 5 مايو 2025',
                                          'ضد السعار - 1 مارس 2025',
                                        ].length -
                                        1)
                                  const Divider(
                                    color: Color(0xFFE0E0E0),
                                    thickness: 1,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Health Status Section
                    _buildSectionHeader(
                      'الحالة الصحية',
                      'assets/images/svg/heart_rate.svg',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoCard([
                      'الأمراض المزمنة : مشاكل في الكبد',
                      'ملاحظات : يحتاج لتحاليل كل شهر ومتابعة تغذية',
                      '  خفيفة',
                    ], EdgeInsets.symmetric(horizontal: 0)),

                    const SizedBox(height: 24),

                    // Attached Files Section
                    _buildSectionHeader(
                      'ملفات مرفقة',
                      'assets/images/svg/add_folder.svg',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoCard([], EdgeInsets.symmetric(horizontal: 16)),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<String> items, EdgeInsetsGeometry margin) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        color: Color(0xFFF6F1E9), // Light beige
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: items.isEmpty
          ? const SizedBox(height: 40)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      SizedBox(height: 10),
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 2),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildSectionHeader(String title, String icon) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 4),
        SvgPicture.asset(icon, width: 20, height: 20, color: AppColor.primary),
      ],
    );
  }
}
