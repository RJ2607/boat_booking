import 'package:boat_booking/utils/firestore_ref.dart';
import 'package:boat_booking/views/booking/boat_details.dart';
import 'package:firestore_ref/firestore_ref.dart';
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
              StreamBuilder(
                stream:
                    FirestoreRef.getBoatListForSelection(passengerNumberController!.text),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data.docs[index];

                      return BoatWidget(
                        boatName: document['name'],
                        description: document['description'],
                        price: document['price'].toString(),
                        image: document['image'],
                        seats: document['availableSeats'].toString(),
                        time: document['fromTime'] + " - " + document['toTime'],
                        passengerNumberController: passengerNumberController,
                        dateController: dateController,
                        docId: document.id,
                      );
                    },
                  );
                },
              ),
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
  final String? time;
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;
  final String? docId;

  const BoatWidget({
    this.boatName,
    this.description,
    this.price,
    this.image,
    this.seats,
    this.time,
    this.passengerNumberController,
    this.dateController,
    required this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to booking details
        Get.to(() => BoatDetails(
              passengerNumberController: passengerNumberController,
              dateController: dateController,
              docId: docId,
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
                      seats! + " seats",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              boatName!,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(time!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
          ],
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
        Text("₹ " + price!,
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
