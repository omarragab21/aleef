import 'package:aleef/shared/assets/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddAnimalScreenTwo extends StatefulWidget {
  const AddAnimalScreenTwo({super.key});

  @override
  State<AddAnimalScreenTwo> createState() => _AddAnimalScreenTwoState();
}

class _AddAnimalScreenTwoState extends State<AddAnimalScreenTwo> {
  String? selectedPetType;
  final List<String> petTypes = ['Dog', 'Cat', 'Bird', 'Fish', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //* back button
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.primary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                flex: 11,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'medical_record'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.stroke1, width: 2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'add_file'.tr(),
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'add_official_documents'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.stroke1, width: 2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'add_file'.tr(),
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.stroke1, width: 2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'add_file'.tr(),
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'where_is_your_pet'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 55.h,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA4D4AE),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF6D9773),
                          width: 2,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedPetType,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF2D2D2D),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF2D2D2D),
                          ),
                          dropdownColor: const Color(0xFFA4D4AE),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPetType = newValue!;
                            });
                          },
                          items: petTypes.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text(value)],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'select_pet_type'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFF6D9773),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                  activeColor: AppColor.primary,
                                  side: BorderSide(
                                    color: AppColor.primary,
                                    width: 2,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'male'.tr(),
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    'assets/images/svg/male.svg',
                                    width: 100,
                                    height: 100,
                                    color: AppColor.primary,
                                  ),
                                ),
                                SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFF6D9773),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                  activeColor: AppColor.primary,
                                  side: BorderSide(
                                    color: AppColor.primary,
                                    width: 2,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'female'.tr(),
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    'assets/images/svg/female.svg',
                                    width: 100,
                                    height: 100,
                                    color: AppColor.primary,
                                  ),
                                ),
                                SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'vaccinations'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.stroke1, width: 2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'vaccination_name'.tr(),
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                height: 1.0,
                                letterSpacing: 0.0,
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //* save button
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to full profile
                        // NavigationService().pushWidget(AddAnimalScreenTwo());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      label: Text(
                        'save'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          height: 1.0, // 100% line-height
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
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
}
