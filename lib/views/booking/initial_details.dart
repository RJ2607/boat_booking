import 'package:boat_booking/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'boat_selection.dart';

class InitialDetails extends StatelessWidget {
  InitialDetails({super.key});

  TextEditingController passengerNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  FocusNode dateFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      passengerNumberController.dispose();
      dateController.dispose();
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Iconsax.arrow_left_2),
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                "Book your Boat",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Fill in the details below to get started",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              TextFieldWidget(
                  controllers: passengerNumberController,
                  labelText: 'Passenger No.',
                  keyboardType: TextInputType.number),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextFieldWidget(
                  controllers: dateController,
                  labelText: 'Date',
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      dateController.text =
                          DateFormat.MMMMEEEEd().format(picked);
                    }
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    redirectToBoatSelection();
                  },
                  child: Text("Start Planning"),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

  void redirectToBoatSelection() {
    if (passengerNumberController.text.isEmpty) {
      Get.snackbar('Error', 'Passenger number is required');
      return;
    }
    if (dateController.text.isEmpty) {
      Get.snackbar('Error', 'Date is required');
      return;
    }

    Get.to(
      () => BoatSelection(
        passengerNumberController: passengerNumberController,
        dateController: dateController,
      ),
    );
  }
}
