import 'package:boat_booking/views/booking/passenger_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/firestore_ref.dart';
import '../../widget/page_app_bar.dart';

class BoatDetails extends StatelessWidget {
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;
  final String? docId;
  const BoatDetails({
    this.passengerNumberController,
    this.dateController,
    required this.docId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //navigate to booking summary
          Get.to(() => PassengerDetails(
                passengerNumberController: passengerNumberController,
                dateController: dateController,
                docId: docId,
              ));
        },
        label: Text("Go to passenger details"),
        icon: Icon(Iconsax.arrow_right),
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: PageAppBar(
          leading: GestureDetector(
            child: Icon(Iconsax.arrow_left_2, size: 30),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          trailing: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
              ),
              onPressed: () async {},
              child: Icon(
                Icons.share,
                size: MediaQuery.of(context).size.width * 0.045,
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
              future: FirestoreRef.getBoatDetails(docId!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Get.snackbar("Error", "Error loading data");
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data!.data()!["image"].toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      snapshot.data!.data()!["name"].toString(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    Text(
                      "Boat has " +
                          snapshot.data!.data()!["availableSeats"].toString() +
                          " seats and is available for booking",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(
                      "Price: " +
                          snapshot.data!.data()!["price"].toString() +
                          " per person",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(
                      dateController!.text +
                          " - " +
                          passengerNumberController!.text +
                          " passengers",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033),
                    ),
                    Divider(),
                    Text(
                      "Amenities",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    Column(
                      children: [
                        ...List.generate(
                          snapshot.data!.data()!["amenities"].length,
                          (index) => Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(snapshot.data!.data()!["amenities"][index]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text("Safety Features",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    Column(
                      children: [
                        ...List.generate(
                          snapshot.data!.data()!["safetyFeatures"].length,
                          (index) => Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(snapshot.data!.data()!["safetyFeatures"]
                                  [index]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
