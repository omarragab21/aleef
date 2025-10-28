import 'package:aleef/modules/user/services/views/vets_screens/confrim_reservation.dart';
import 'package:aleef/modules/user/services/models/doctor_model.dart';
import 'package:aleef/modules/user/services/models/appointment_model.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatefulWidget {
  final DoctorModel? doctor;
  final AvailableAppointmentModel? appointment;

  const BookAppointmentScreen({super.key, this.doctor, this.appointment});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedDate;
  String? selectedTime;
  String? selectedPet;
  bool isTodayExpanded = true;
  bool isTomorrowExpanded = false;
  bool isPetSelectionExpanded = false;
  bool isHomeVisitSelected = false; // Default to clinic visit

  // TODO: Replace with actual pets from user data
  final List<String> pets = ['لولو', 'أوسكار', 'فقاعة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'choose_time'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDateSection(),
                    SizedBox(height: 24),
                    _buildPetSelectionSection(),
                  ],
                ),
              ),
            ),
            Expanded(child: _buildConfirmButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    if (widget.appointment == null) {
      return Center(
        child: Text(
          'no_appointment_data'.tr(),
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected appointment date
        _buildDateCard(
          title:
              '${widget.appointment!.day} ${widget.appointment!.dateDisplay}',
          isExpanded: isTodayExpanded,
          isActive: true,
          onTap: () => setState(() => isTodayExpanded = !isTodayExpanded),
          child: isTodayExpanded ? _buildTimeSlots() : null,
        ),
      ],
    );
  }

  Widget _buildDateCard({
    required String title,
    required bool isExpanded,
    required bool isActive,
    required VoidCallback? onTap,
    Widget? child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFF8F6F1) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ]
            : [],
        border: Border.all(
          color: isActive ? AppColor.primary : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 30,
                      color: isActive ? AppColor.primary : Colors.grey[600],
                    ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFB0B0B0), width: 1),
                    ),
                  ),
                ),
              ],
              if (child != null) ...[
                SizedBox(height: 16),
                Padding(padding: const EdgeInsets.all(16.0), child: child),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    if (widget.appointment == null ||
        widget.appointment!.availableSlots.isEmpty) {
      return Center(
        child: Text(
          'no_time_slots_available'.tr(),
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.9,
      ),
      itemCount: widget.appointment!.availableSlots.length,
      itemBuilder: (context, index) {
        final slot = widget.appointment!.availableSlots[index];
        final time = slot.time;
        final isSelected = selectedTime == time;

        return InkWell(
          onTap: () => setState(() => selectedTime = time),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primary : Color(0xFFA4D4AE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPetSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أختر الحيوان',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8F6F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(
                () => isPetSelectionExpanded = !isPetSelectionExpanded,
              ),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9.0,
                    vertical: 5.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F1E9),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xFF6D9773),
                            width: 2,
                          ),
                        ),
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedPet ?? 'أختر الحيوان',
                              style: TextStyle(
                                color: selectedPet != null
                                    ? Colors.black
                                    : Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              isPetSelectionExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: AppColor.primary,
                            ),
                          ],
                        ),
                      ),
                      if (isPetSelectionExpanded) ...[
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xFF6D9773),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 0,
                              ), // To ensure gap at the top if needed
                              ...pets.asMap().entries.map((entry) {
                                final pet = entry.value;
                                final isLast = entry.key == pets.length - 1;
                                return Column(
                                  children: [
                                    _buildPetOption(pet),
                                    if (!isLast) SizedBox(height: 14),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPetOption(String pet) {
    final isSelected = selectedPet == pet;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedPet = pet;
              isPetSelectionExpanded = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                SizedBox(width: 12),
                Text(
                  pet,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[700],
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (pet != pets.last) Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }

  Widget _buildConfirmButton() {
    final isBookingValid = selectedTime != null && selectedPet != null;

    return Center(
      child: GestureDetector(
        onTap: isBookingValid
            ? () {
                NavigationService().pushWidget(
                  ConfrimReservation(
                    doctor: widget.doctor,
                    appointment: widget.appointment,
                    selectedTime: selectedTime,
                    selectedPet: selectedPet,
                    consultationType: isHomeVisitSelected
                        ? 'زيارة منزلية'
                        : 'كشف عيادة',
                    consultationPrice: widget.doctor?.price,
                  ),
                );
              }
            : null,
        child: Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isBookingValid ? const Color(0xFF6D9773) : Colors.grey[400],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isBookingValid
                  ? const Color(0xFF6D9773)
                  : Colors.grey[400]!,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            isBookingValid ? 'تأكيد الحجز' : 'اختر الوقت والحيوان',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              height: 1.0,
              letterSpacing: 0,
              color: isBookingValid ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
