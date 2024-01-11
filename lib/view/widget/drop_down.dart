import 'package:blood_donation/controller/dropdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownProvider>(
      builder: (context, provider, child) => 
       DropdownButton<String?>(
          value: provider.selectedGroups,
          items: provider.bloodGroup.map((grp) {
            return DropdownMenuItem<String>(
                value: grp, child: Text(grp));
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              provider.dropdownValuechange(newValue);
            }
          }),
    );
  }
}