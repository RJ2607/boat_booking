import 'package:boat_booking/utils/firestore_ref.dart';
import 'package:boat_booking/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../model/passenger_model.dart';
import '../../widget/page_app_bar.dart';
import 'booking_payment.dart';

class PassengerDetails extends StatefulWidget {
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;
  final String? docId;
  PassengerDetails({
    this.passengerNumberController,
    this.dateController,
    required this.docId,
    super.key,
  });

  @override
  State<PassengerDetails> createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  final TextEditingController? emailController = TextEditingController();

  final TextEditingController? phoneNumberController = TextEditingController();

  final TextEditingController? fullNameController = TextEditingController();

  final TextEditingController? ageController = TextEditingController();

  final TextEditingController? genderController = TextEditingController();

  List<PassengerModel> passengers = [];

  var snapshot;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      FirestoreRef.getBoatDetails(widget.docId).then((value) {
        setState(() {
          snapshot = value;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    phoneNumberController!.dispose();
    fullNameController!.dispose();
    ageController!.dispose();
    genderController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (snapshot == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
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
              children: [
                boatSummary(context, snapshot),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                contactDetails(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                passengerDetails(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                FloatingActionButton.extended(
                  onPressed: () {
                    //navigate to booking summary
                    if (emailController!.text.isEmpty) {
                      Get.snackbar('Error', 'Email is required');
                      return;
                    }
                    if (phoneNumberController!.text.isEmpty) {
                      Get.snackbar('Error', 'Phone number is required');
                      return;
                    }
                    if (phoneNumberController!.text.length != 10) {
                      Get.snackbar('Error', 'Phone number is invalid');
                      return;
                    }
                    if (int.parse(widget.passengerNumberController!.text) !=
                        passengers.length) {
                      Get.snackbar('Error',
                          'Passenger number does not match the number of passengers');
                      return;
                    }
                    Get.to(() => BookingPayment(
                          passengers: passengers,
                          snapshot: snapshot,
                          docId: widget.docId,
                        ));
                  },
                  label: Text("Go to payment"),
                  icon: Icon(Iconsax.arrow_right),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ],
            )),
      ),
    );
  }

  passengerDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: FutureBuilder(
          future: getPassengers(),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Passenger Details",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text("Select atleast one passenger"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                FilledButton(
                  onPressed: () {
                    addPassenger(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.user_add),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text("Add Passenger"),
                    ],
                  ),
                ),
                ...List.generate(
                    snapshot.data == null ? 0 : snapshot.data!.length,
                    (index) => Column(
                          children: [
                            Divider(),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    child: Icon(Iconsax.user)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data![index].fullName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(snapshot.data![index].gender!),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        Text(snapshot.data![index].age! +
                                            " years"),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ))
              ],
            );
          }),
    );
  }

  Future<List<PassengerModel>> getPassengers() async {
    return passengers;
  }

  Future<dynamic> addPassenger(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Passenger",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Iconsax.close_circle),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  TextFieldWidget(
                    controllers: fullNameController,
                    labelText: "Full Name",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Age",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      DropdownMenu(
                          menuHeight: 300,
                          controller: genderController,
                          enableFilter: true,
                          label: const Text('Gender'),
                          width: MediaQuery.of(context).size.width * 0.45,
                          inputDecorationTheme: InputDecorationTheme(
                            fillColor: Theme.of(context).colorScheme.background,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          dropdownMenuEntries: const <DropdownMenuEntry<
                              String>>[
                            DropdownMenuEntry(
                              value: 'Male',
                              label: 'Male',
                            ),
                            DropdownMenuEntry(
                              value: 'Female',
                              label: 'Female',
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  FilledButton(
                    onPressed: () {
                      addPassengerController();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.user_add),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text("Add Passenger To List"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  )
                ],
              ),
            ));
  }

  addPassengerController() {
    if (fullNameController!.text.isEmpty) {
      Get.snackbar('Error', 'Full name is required');
      return;
    }
    if (ageController!.text.isEmpty) {
      Get.snackbar('Error', 'Age is required');
      return;
    }

    if (genderController!.text.isEmpty) {
      Get.snackbar('Error', 'Gender is required');
      return;
    }

    if (fullNameController!.text.isNotEmpty &&
        ageController!.text.isNotEmpty &&
        genderController!.text.isNotEmpty) {
      setState(() {
        passengers.add(PassengerModel(
            age: ageController!.text,
            fullName: fullNameController!.text,
            gender: genderController!.text));
      });
      fullNameController!.clear();
      ageController!.clear();
      genderController!.clear();

      Navigator.pop(context);
    }
  }

  contactDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Details",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
              "The ticket will be sent to the email and phone number provided"),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: TextFieldWidget(
              controllers: emailController,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              cursorHeight: 18,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: TextFieldWidget(
              controllers: phoneNumberController,
              labelText: "Mobile Number",
              keyboardType: TextInputType.phone,
              cursorHeight: 18,
            ),
          ),
        ],
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
            children: [
              Icon(
                Iconsax.user,
                size: MediaQuery.of(context).size.width * 0.04,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(widget.passengerNumberController!.text + " seats",
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
