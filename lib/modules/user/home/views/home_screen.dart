import 'package:aleef/modules/user/services/models/pet_model.dart';
import 'package:aleef/modules/user/services/models/doctor_model.dart';
import 'package:aleef/modules/user/services/views/store_screens/product_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../../services/view_models/services_view_model.dart';
import '../../profile/view_models/profile_view_model.dart';
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
                Consumer<ProfileViewModel>(
                  builder: (context, profileViewModel, child) {
                    return _buildHeader(profileViewModel);
                  },
                ),
                const SizedBox(height: 24),

                // Pet Profiles Section
                Consumer<ServicesViewModel>(
                  builder: (context, servicesViewModel, child) {
                    return _buildPetProfiles(servicesViewModel.pets);
                  },
                ),
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

  Widget _buildHeader(ProfileViewModel profileViewModel) {
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
                    'أهلاً, ${profileViewModel.profile?.fullName ?? 'أحمد'}',
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

  Widget _buildPetProfiles(List<PetModel> pets) {
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
              if (pets.isEmpty)
                Expanded(
                  child: Container(
                    height: 90,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 16),

                    child: Text('no_pets_available'.tr()),
                  ),
                )
              else if (pets.isNotEmpty)
                ...pets.map(
                  (pet) => _buildPetProfileItem(
                    pet.name ?? '',
                    pet.imageUrl ?? '',
                    Colors.grey,
                  ),
                ),

              // Pet Profile 1 - Fish
              // _buildPetProfileItem(
              // // _buildPetProfileItem(
              // //   'فقاعة',
              // //   'assets/images/png/cat.jpg', // Using existing image as placeholder
              // //   Colors.blue,
              // // ),

              // // Pet Profile 2 - Dog
              // //    _buildPetProfileItem(
              //   'أوسكار',
              // //   'assets/images/png/cat.jpg', // Using existing image as placeholder
              // //   Colors.brown,
              // // ),

              // // Pet Profile 3 - Cat
              // _buildPetProfileItem(
              //   'لولو',
              //   'assets/images/png/cat.jpg', // Using existing image as placeholder
              //   Colors.grey,
              // ),
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
    return Selector<ServicesViewModel, List<PetModel>>(
      selector: (_, vm) => vm.pets,
      shouldRebuild: (prev, next) => !identical(prev, next),
      builder: (context, pets, child) {
        final PetModel? pet = pets.isNotEmpty ? pets.first : null;

        return pet != null
            ? Container(
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
                            image:
                                pet?.imageUrl == null ||
                                    (pet?.imageUrl?.isEmpty ?? true)
                                ? const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/png/cat.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(pet!.imageUrl!),
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
                                    pet?.name ?? 'غير مُسَمّى',
                                    style: AppTextStyles.titleSmall.copyWith(
                                      color: AppColor.title,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                pet == null
                                    ? 'لا يوجد حيوان أليف محدد'
                                    : '${pet.type ?? 'نوع غير معروف'} - ${pet.breed ?? 'سلالة غير معروفة'}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColor.title.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pet == null
                                    ? ''
                                    : 'العمر: ${pet.age ?? 'غير محدد'}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColor.title.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pet == null
                                    ? ''
                                    : 'الوزن: ${pet.weight ?? 'غير محدد'}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColor.title.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.end,
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
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildStorePromotionCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
      },
      child: Container(
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
              right: 10,
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
              padding: const EdgeInsets.only(left: 36, right: 18),
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
                        fontSize: 15,
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
      ),
    );
  }

  Widget _buildVeterinarianSection() {
    return Consumer<ServicesViewModel>(
      builder: (context, servicesViewModel, child) {
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

            if (servicesViewModel.isLoadingDoctors)
              const Center(
                child: CircularProgressIndicator(color: AppColor.primary),
              )
            else if (servicesViewModel.doctorsError != null)
              Text(
                servicesViewModel.doctorsError ?? 'حدث خطأ غير متوقع',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.red),
              )
            else if (servicesViewModel.doctors.isEmpty)
              Text(
                'لا يوجد أطباء متاحون الآن',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.title,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              SizedBox(
                height: 175.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: servicesViewModel.doctors.length,
                  itemBuilder: (context, index) {
                    final DoctorModel doctor = servicesViewModel.doctors[index];
                    return _buildVeterinarianCard(doctor);
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildVeterinarianCard(DoctorModel doctor) {
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
              image: doctor.image == null
                  ? const DecorationImage(
                      image: AssetImage('assets/images/png/cat.jpg'),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: NetworkImage(doctor.image!),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 8),

          // Doctor Name
          Text(
            doctor.name,
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
                (doctor.rating ?? 0).toStringAsFixed(1),
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
                'سعر الحجز :${doctor.price ?? 0} ريال',
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
