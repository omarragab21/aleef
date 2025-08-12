import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../../../../shared/assets/app_color.dart';
import '../../../../shared/assets/app_text_styles.dart';
import '../../../../shared/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load home data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const AppDrawer(),

      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          // if (viewModel.isLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(color: AppColor.primary),
          //   );
          // }

          // if (viewModel.error != null) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'Error: ${viewModel.error}',
          //           style: const TextStyle(color: Colors.red),
          //         ),
          //         const SizedBox(height: 16),
          //         ElevatedButton(
          //           onPressed: () => viewModel.loadHomeData(),
          //           child: const Text('Retry'),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(),
                const SizedBox(height: 24),

                // Pet Profiles Section
                _buildPetProfiles(),
                const SizedBox(height: 24),

                // Pet Profile Details Card
                _buildPetProfileCard(),
                const SizedBox(height: 16),

                // Store Promotion Card
                _buildStorePromotionCard(),
                const SizedBox(height: 24),

                // Veterinarian Booking Section
                _buildVeterinarianSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Bell Icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: AppColor.primary,
            size: 24,
          ),
        ),

        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'أهلاً, أحمد',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColor.title,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/svg/content.svg',
                            color: AppColor.primary,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              Text(
                'كيف حال حيوانك الأليف اليوم !',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.title.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetProfiles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'حيواناتي الأليفة',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Add New Pet Button
              Container(
                width: 100,
                margin: const EdgeInsets.only(right: 2),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColor.lightGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.primary),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              // Pet Profile 1 - Fish
              _buildPetProfileItem(
                'فقاعة',
                'assets/images/png/cat.jpg', // Using existing image as placeholder
                Colors.blue,
              ),

              // Pet Profile 2 - Dog
              _buildPetProfileItem(
                'أوسكار',
                'assets/images/png/cat.jpg', // Using existing image as placeholder
                Colors.brown,
              ),

              // Pet Profile 3 - Cat
              _buildPetProfileItem(
                'لولو',
                'assets/images/png/cat.jpg', // Using existing image as placeholder
                Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetProfileItem(String name, String imagePath, Color color) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primary),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ملف حيوانك الأليف',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              // Pet Image
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/cat.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),

              // Pet Details
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.pets,
                          color: AppColor.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'لولو',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColor.title,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'قطة - شيرازي',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.title.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'أخر تطعيم : 5 مايو 2025',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColor.title.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'نوع التطعيم : ضد الديدان',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColor.title.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // View Full Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to full profile
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

  Widget _buildStorePromotionCard() {
    return Container(
      height: 145.h,

      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Promotion Text Card (with padding to the left for the image)
          Positioned(
            top: 40.h,
            right: 5,
            child: SizedBox(
              width: 40.w,
              height: 40.h,
              child: SvgPicture.asset(
                'assets/images/svg/group.svg',
                width: 40.w,
                height: 40.h,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25),
            padding: const EdgeInsets.only(left: 36, right: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'كل المستلزمات اللي محتاجها حيوانك الأليف موجودة في متجرنا',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColor.title,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Dog Image (on top, left)
          Positioned(
            left: -20,
            bottom: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/png/dog_annoucment.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVeterinarianSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to full list
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'عرض القائمة',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'احجز مع طبيب بيطري',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColor.title,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 175.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildVeterinarianCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVeterinarianCard() {
    return Container(
      width: 150.w,
      height: 175.h,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        children: [
          // Doctor Image
          const Spacer(),
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/images/png/cat.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Doctor Name
          Text(
            'د. محمد أحمد',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '5.0',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.title,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 4),
              Text(
                'سعر الحجز : 200 ج.م',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                'assets/images/svg/money_dollar.svg',
                width: 16.w,
                height: 16.h,
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
