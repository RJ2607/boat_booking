import 'package:boat_booking/views/booking/boat_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../widget/page_app_bar.dart';

class BoatSelection extends StatelessWidget {
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;

  BoatSelection({
    this.passengerNumberController,
    this.dateController,
    super.key,
  });

  //call texteditingcontroller through getx

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: PageAppBar(
          leading: GestureDetector(
            child: Icon(Iconsax.arrow_left_2, size: 30),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
          dateController: dateController,
          passengerNumberController: passengerNumberController,
          trailing: OutlinedButton(
              onPressed: () {
                //navigate to modify details
                Get.toNamed("/booking_details");
              },
              child: Text("Modify")),
          title: Text("Boat Selection"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Showing available boats",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ...List.generate(
                  1,
                  (index) => BoatWidget(
                        boatName: "Boat Name",
                        description: "description",
                        price: "price",
                        image:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWP-0c4ZhiwP4Xm__iHor9jlpUWR_bHknupg&s",
                        seats: "40 seats",
                        passengerNumberController: passengerNumberController,
                        dateController: dateController,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

class BoatWidget extends StatelessWidget {
  final String? boatName;
  final String? description;
  final String? price;
  final String? image;
  final String? seats;
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;

  const BoatWidget({
    this.boatName,
    this.description,
    this.price,
    this.image,
    this.seats,
    this.passengerNumberController,
    this.dateController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to booking details
        Get.to(BoatDetails(
          passengerNumberController: passengerNumberController,
          dateController: dateController,
        ));
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          SmoothClipRRect(
            smoothness: 0.8,
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image!,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SmoothClipRRect(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                      vertical: MediaQuery.of(context).size.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Text(
                      seats!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                borderRadius: BorderRadius.circular(30),
                smoothness: 0.8,
              ),
            ),
          ),
        ]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Text(
          boatName!,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.003,
        ),
        Text(description!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.003,
        ),
        Text(price!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
      ]),
    );
  }
}
