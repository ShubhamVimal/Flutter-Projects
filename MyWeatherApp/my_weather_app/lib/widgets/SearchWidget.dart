import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:my__weather_app/controller/WeatherController.dart';
import 'package:my__weather_app/data/WorldCitiesList.dart';

class SearchByName extends StatefulWidget {
  SearchByName({
    Key? key,
  }) : super(key: key);

  @override
  _SearchByNameState createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  final WeatherController _controller = Get.find();

  final TextEditingController searchTED = TextEditingController();

  String? _selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: searchTED,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                labelText: 'Search City',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)))),
        suggestionsCallback: (pattern) {
          return CitiesService.getSuggestions(pattern);
        },
        itemBuilder: (BuildContext context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (String suggestion) {
          _controller.searchByName(name: suggestion);
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please select a city';
          }
        },
        onSaved: (value) {
          setState(() {
            _selectedCity = value;
          });
        },
      ),
    );
  }
}
