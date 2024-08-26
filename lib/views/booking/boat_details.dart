import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widget/page_app_bar.dart';

class BoatDetails extends StatelessWidget {
  final TextEditingController? passengerNumberController;
  final TextEditingController? dateController;
  const BoatDetails({
    this.passengerNumberController,
    this.dateController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //navigate to booking summary
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
              onPressed: () {},
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWP-0c4ZhiwP4Xm__iHor9jlpUWR_bHknupg&s"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Boat Name",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              Text(
                "Boat has 40 seats and is available for booking",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
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
                    1,
                    (index) => Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text("Life Jackets"),
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
                    1,
                    (index) => Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text("First Aid Kit"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
