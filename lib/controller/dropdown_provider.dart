import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier{
   final bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
   var selectedGroups='A+';
     dropdownValuechange(newValue){
    selectedGroups=newValue;
    notifyListeners();
  }
}