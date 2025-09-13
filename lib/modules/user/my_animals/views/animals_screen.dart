import 'package:aleef/modules/user/my_animals/views/add_animal_screen.dart';
import 'package:aleef/modules/user/my_animals/views/animal_details_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../view_models/animals_view_model.dart';
import '../models/animal_model.dart';
import '../../../../shared/assets/app_color.dart';
import '../../../../shared/assets/app_text_styles.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  @override
  void initState() {
    super.initState();
    // Load animals when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnimalsViewModel>().loadAnimals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.title),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'حيواناتي',
          style: TextStyle(
            color: AppColor.title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<AnimalsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadAnimals(),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }

          if (viewModel.animals.isEmpty) {
            return _buildEmptyState();
          }

          return _buildAnimalsList(viewModel.animals);
        },
      ),
    );
  }

  Widget _buildAnimalsList(List<AnimalModel> animals) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          // Animal cards
          Expanded(
            flex: 30,
            child: ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                return _buildAnimalCard(animals[index]);
              },
            ),
          ),
          Spacer(),
          // Add new pet button
          _buildAddNewPetButton(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildAnimalCard(AnimalModel animal) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.stroke2, width: 1),
      ),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primary, width: 1),
              image: DecorationImage(
                image: AssetImage('assets/images/png/cat.jpg'),

                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لولو',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const Icon(Icons.pets, color: AppColor.primary, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'قطة - شيرازي',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 16,
              height: 1.0,
              letterSpacing: 0,
              color: Color(0xFF2D2D2D),
              // No leading-trim in Flutter, and textAlign is set on the Text widget, not style
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // View Full Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to full profile
                NavigationService().pushWidget(const AnimalDetailsScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.pets, size: 20),
              label: Text(
                'عرض الملف الكامل',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewPetButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to add animal screen
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إضافة حيوان جديد',
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
            const SizedBox(width: 8),
            const Icon(Icons.add, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Deer illustration
            SvgPicture.asset(
              'assets/images/svg/empty_animal.svg',
              width: 400.w,
              height: 400.h,
            ),
            const SizedBox(height: 32),

            // Arabic text
            Text(
              'ما في أي حيوان أليف مضاف لحد الحين.',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xFF2D2D2D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'تقدر تضيف أول حيوان علشان نعرضه لك هني.',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xFF2D2D2D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Add new pet button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to add animal screen
                  NavigationService().pushWidget(const AddAnimalScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'إضافة حيوان جديد',
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
                    const SizedBox(width: 8),
                    const Icon(Icons.add, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AnimalModel animal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('delete_animal'.tr()),
        content: Text(
          'confirm_delete_animal'.tr().replaceAll(
            '{animalName}',
            animal.name ?? '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AnimalsViewModel>().deleteAnimal(animal.id!);
            },
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }
}
