import 'package:flutter/material.dart';

class ItemDetailFormPage extends StatefulWidget {
  const ItemDetailFormPage({super.key});

  @override
  State createState() => _ItemDetailFormPageState();
}

class _ItemDetailFormPageState extends State<ItemDetailFormPage> {
  // Controllers for each text field
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateLostController = TextEditingController();
  final TextEditingController _locationLostController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _contactFinderController =
      TextEditingController();
  final TextEditingController _rewards = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost Items'),
        centerTitle: true,
        actions: const [
          Icon(Icons.sort),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image input placeholder (you can add an image picker here)
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      Image.network(
                        'https://media.istockphoto.com/id/1403500817/photo/the-craggies-in-the-blue-ridge-mountains.jpg?s=612x612&w=0&k=20&c=N-pGA8OClRVDzRfj_9AqANnOaDS3devZWwrQNwZuDSk=',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.network(
                        'https://media.istockphoto.com/id/1403500817/photo/the-craggies-in-the-blue-ridge-mountains.jpg?s=612x612&w=0&k=20&c=N-pGA8OClRVDzRfj_9AqANnOaDS3devZWwrQNwZuDSk=',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.network(
                        'https://media.istockphoto.com/id/1403500817/photo/the-craggies-in-the-blue-ridge-mountains.jpg?s=612x612&w=0&k=20&c=N-pGA8OClRVDzRfj_9AqANnOaDS3devZWwrQNwZuDSk=',
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Add an image",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //Logic
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Item Description input
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hintText: 'Enter a detailed description of the item',
              ),

              // Date Lost input
              _buildTextField(
                controller: _dateLostController,
                label: 'Lost On',
                hintText: 'Enter the date the item was lost',
              ),

              // Location Lost input
              _buildTextField(
                controller: _locationLostController,
                label: 'Lost At',
                hintText: 'Enter the location where the item was lost',
              ),

              // Category input
              _buildTextField(
                controller: _categoryController,
                label: 'Category',
                hintText:
                    'Enter the category of the item (e.g., Electronics, Accessories)',
              ),

              // Contact Finder input
              _buildTextField(
                controller: _contactFinderController,
                label: 'Contact Finder',
                hintText: 'Enter contact information for the finder',
              ),

              // Status input
              _buildTextField(
                controller: _rewards,
                label: 'Reward',
                hintText: 'Enter if you want to any reward for Finder',
              ),

              // Additional Notes input
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                hintText: 'Enter any additional information',
              ),

              const SizedBox(height: 20),

              const Text(
                "Please, select the area in which your item is lost",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: const Text(
                  "Map",
                  style: TextStyle(
                    inherit: true,
                    fontSize: 25,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Save button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to save or submit the form data
                    _saveFormData();
                  },
                  child: const Text('Save Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Method to handle saving form data (you can modify this based on your backend logic)
  void _saveFormData() {
    String description = _descriptionController.text;
    String dateLost = _dateLostController.text;
    String locationLost = _locationLostController.text;
    String category = _categoryController.text;
    String contactFinder = _contactFinderController.text;
    String status = _rewards.text;
    String notes = _notesController.text;

    // You can now use this data to save it to a backend or local storage
    print('Description: $description');
    print('Lost On: $dateLost');
    print('Lost At: $locationLost');
    print('Category: $category');
    print('Contact Finder: $contactFinder');
    print('Status: $status');
    print('Notes: $notes');

    // Clear fields after submission
    _clearFormFields();
  }

  // Method to clear the text fields after saving
  void _clearFormFields() {
    _descriptionController.clear();
    _dateLostController.clear();
    _locationLostController.clear();
    _categoryController.clear();
    _contactFinderController.clear();
    _rewards.clear();
    _notesController.clear();
  }
}
