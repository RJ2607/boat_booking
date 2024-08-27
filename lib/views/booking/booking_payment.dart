import 'package:boat_booking/utils/firestore_ref.dart';
import 'package:boat_booking/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../model/passenger_model.dart';
import '../../widget/page_app_bar.dart';

class BookingPayment extends StatelessWidget {
  final List<PassengerModel>? passengers;
  final dynamic snapshot;
  final docId;

  const BookingPayment(
      {this.passengers,
      required this.snapshot,
      required this.docId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //navigate to booking summary
          int seats = snapshot["availableSeats"] - passengers!.length;
          try {
            FirestoreRef.updateSeatAvailable(docId, seats);
          } catch (e) {
            Get.snackbar('Error', 'Something went wrong');

            return;
          } finally {
            Get.snackbar('Succesfull', 'Booking Confirmed');

            Get.to(() => MyHomePage());
          }
        },
        label: Text("Go to payment"),
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
              boatSummary(context, snapshot),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text("Bill Breakdown",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  Icon(Iconsax.user,
                      size: MediaQuery.of(context).size.width * 0.04),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(passengers!.length.toString() + " Passengers",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w300,
                      )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ...List.generate(
                  passengers!.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(passengers![index].fullName.toString(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w300,
                                )),
                            Text("₹ " + snapshot["price"].toString(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w300,
                                )),
                          ],
                        ),
                      )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total(incl. GST)",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      "₹ " +
                          (passengers!.length * snapshot["price"]).toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  boatSummary(BuildContext context, var snapshot) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot["name"].toString(),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(snapshot['fromTime'].toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  )),
              Icon(Iconsax.ship),
              Text(snapshot["toTime"].toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.user,
                    size: MediaQuery.of(context).size.width * 0.04,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(passengers!.length.toString() + " seats",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Text("₹ " + (passengers!.length * snapshot["price"]).toString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
