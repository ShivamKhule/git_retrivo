// ignore_for_file: file_names

import 'dart:io';
import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:homepage/Anuj/LostModel.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../Kaushal/Lost Page/lost_list.dart';
import 'LostModel.dart';

class ReportLostItemPage extends StatelessWidget {
  const ReportLostItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReportLost();
  }
}

class ReportLost extends StatefulWidget {
  const ReportLost({super.key});

  @override
  State createState() => _ReportFoundState();
}

class _ReportFoundState extends State<ReportLost>
    with SingleTickerProviderStateMixin {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? categoryController;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mapLocationController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  GoogleMapController? _controller;
  LatLng? _pickedLocation;
  String address = '';

  // List<LostModel> lostItems = [];

  String? selectedCategory;
  final List<String> _categories = [
    'Electronics',
    'Personal Items',
    'Documents',
    'Clothing and Accessories',
    'Transportation',
    'Pets',
    'Household Items',
    'Others',
  ];

  // void submit(){

  // }

  // XFile? image;
  // final ImagePicker picker = ImagePicker();

  // // XFile? selectedFile;

  // Future<void> pickImage(ImageSource source) async {
  //   final XFile? pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       image = File(pickedFile.path);
  //       // selectedFile =
  //     });
  //   }
  // }

  File? image;
  final ImagePicker picker = ImagePicker();

  final ImagePicker billpicker = ImagePicker();
  File? billimage;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Store as XFile
      });
    }
  }

  Future<void> billpickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        billimage = File(pickedFile.path); // Store as XFile
      });
    }
  }

  // Function to open map dialog and get the current location
  Future<void> _openMapDialog() async {
    Position position = await _getCurrentPosition();
    LatLng currentPosition = LatLng(position.latitude, position.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition,
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    onTap: (LatLng latLng) async {
                      setState(() {
                        _pickedLocation = latLng;
                      });
                      await _fetchAddress(latLng);
                    },
                    markers: _pickedLocation == null
                        ? <Marker>{} // Specify the type explicitly as <Marker>
                        : {
                            Marker(
                              markerId: const MarkerId("pickedLocation"),
                              position: _pickedLocation!,
                            ),
                          },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_pickedLocation != null) {
                          Navigator.pop(context);
                          setState(() {
                            mapLocationController.text = address;
                          });
                        }
                      },
                      child: const Text("Select Location"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to get current position
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _fetchAddress(LatLng latLng) async {
    try {
      // Fetch the list of placemarks from the given latitude and longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        // Get the first result (usually, the most relevant address)
        Placemark place = placemarks[0];

        // Initialize an empty string to hold the full street address
        String fullStreetAddress = '';

        // Combine street number and street name if available
        if (place.subThoroughfare != null) {
          fullStreetAddress +=
              "${place.subThoroughfare!} "; // Street number (if exists)
        }
        if (place.thoroughfare != null) {
          fullStreetAddress += place.thoroughfare!; // Street name
        }

        // Format the address with locality, administrative area, and country
        String detailedAddress =
            '$fullStreetAddress, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';

        // Clean up any trailing commas or null values
        String briefAddress = detailedAddress.replaceAll(
            RegExp(r',\s*$'), ''); // Trim trailing commas

        setState(() {
          address =
              briefAddress; // Store the fetched address in the _address variable
        });
      }
    } catch (e) {
      setState(() {
        address =
            'Address not found'; // In case of error, set a default message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedCategory = null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/anuj/reporting_img/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/anuj/reporting_img/light-1.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/anuj/reporting_img/light-2.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/anuj/reporting_img/clock.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 80),
                        child: const Center(
                          child: Text(
                            "Report Lost Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .4),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Item Name",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: TextField(
                              controller: descriptionController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Item Description",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Location Lost
                          GestureDetector(
                            onTap: () => _openMapDialog,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]!),
                                ),
                              ),
                              child: TextField(
                                controller: mapLocationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Location Lost",
                                  labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.location_on,
                                      size: 30,
                                    ),
                                    onPressed: _openMapDialog,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: DropdownButtonFormField(
                              onChanged: (newValue) {
                                selectedCategory = null;
                                setState(() {
                                  selectedCategory = newValue;
                                  categoryController = selectedCategory;
                                });
                              },
                              items: _categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Category",
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: TextField(
                              controller: dateController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Item Lost Date",
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2025),
                                );
                                String formattedDate =
                                    DateFormat.yMd().format(pickedDate!);
                                setState(() {
                                  dateController.text = formattedDate;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: TextField(
                              controller: locationController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Location Lost",
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[100]!),
                              ),
                            ),
                            child: TextField(
                              controller: rewardController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Reward*(Optional)",
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          image != null
                              ? Image.file(
                                  image!,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : const Text("No image selected"),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.photo_library),
                            label: const Text("Choose from Gallery"),
                            onPressed: () => pickImage(ImageSource.gallery),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Take a Photo"),
                            onPressed: () => pickImage(ImageSource.camera),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //pick image for bill receipt
                          const Text("Pick an image for Bill Receipt.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          billimage != null
                              ? Image.file(
                                  image!,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : const Text("No image selected"),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.photo_library),
                            label: const Text("Choose from Gallery"),
                            onPressed: () => pickImage(ImageSource.gallery),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Take a Photo"),
                            onPressed: () => pickImage(ImageSource.camera),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1200),
                    child: GestureDetector(
                      onTap: () async {
                        // submit();

                        // print("1");
                        print(categoryController);
                        if (nameController.text.trim().isNotEmpty &&
                                dateController.text.trim().isNotEmpty &&
                                locationController.text.trim().isNotEmpty &&
                                mapLocationController.text.trim().isNotEmpty &&
                                descriptionController.text.trim().isNotEmpty &&
                                numberController.text.trim().isNotEmpty
                            // image != null
                            ) {
                          print(categoryController);
                          print(categoryController);

                          //Item image
                          String fileName =
                              image!.path + DateTime.now().toString();

                          print(categoryController);
                            await FirebaseStorage.instance
                                .ref()
                                .child(fileName)
                                .putFile(image!);

                          log("Download item url from Firebase");

                          String url = await FirebaseStorage.instance
                              .ref()
                              .child(fileName)
                              .getDownloadURL();

                          log(url);

                          //Bill image
                          String billfileName =
                              billimage!.path + DateTime.now().toString();

                            await FirebaseStorage.instance
                                .ref()
                                .child(billfileName)
                                .putFile(image!);

                          log("Download bill receipt url from Firebase");

                          String billurl = await FirebaseStorage.instance
                              .ref()
                              .child(billfileName)
                              .getDownloadURL();

                          log(url);

                          Map<String, dynamic> data = {
                            "category": categoryController.toString(),
                            "date": dateController.text.trim(),
                            "description": descriptionController.text.trim(),
                            "itemName": nameController.text.trim(),
                            "location": locationController.text.trim(),
                            "mobileNumber": numberController.text.trim(),
                            "reward": rewardController.text.trim(),
                            "maplocation": mapLocationController.text.trim(),
                            "billImg" : billurl,
                            "lostImg": url,
                          };

                          log("DATA ADDED :- $data");

                          DocumentReference ref = await FirebaseFirestore
                              .instance
                              .collection("lostItemsInfo")
                              .add(data);

                          log("ADDED DATA:- Document ID: ${ref.id}, Path: ${ref.path}");

                          // log("DATA ADDED :-");

                          nameController.clear();
                          dateController.clear();
                          locationController.clear();
                          mapLocationController.clear();
                          descriptionController.clear();
                          rewardController.clear();
                          selectedCategory = null;
                          image = null;
                          billimage = null;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data Added"),
                            ),
                          );

                          QuerySnapshot response = await FirebaseFirestore
                              .instance
                              .collection("lostItemsInfo")
                              .get();

                          // log(response as String);
                          lostCards.clear();
                          for (var value in response.docs) {
                            // print(value['palyerName']);
                            try {
                              lostCards.add(
                                LostModel(
                                  id: value.id,
                                  name: value['itemName'] ?? "Unknown",
                                  category:
                                      value['category'] ?? "Uncategorized",
                                  date: value['date'] ?? "Unknown date",
                                  location:
                                      value['location'] ?? "Unknown location",
                                  mapLocation: value['mapLocation'] ??
                                      "Location not given",
                                  description:
                                      value['description'] ?? "No description",
                                  number: value['mobileNumber'] ?? "No number",
                                  url: value['lostImg'] ?? "",
                                  billurl: value['billImg'].isEmpty ? "" :value["billImg"],
                                  reward: value['reward'].isEmpty
                                      ? "No Reward"
                                      : value['reward'],
                                ),
                              );
                            } catch (e) {
                              log("Error processing document ${value.id}: $e");
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 174, 189, 212),
                              Color(0xff6991c7),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
