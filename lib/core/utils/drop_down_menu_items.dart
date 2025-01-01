// import 'package:flutter/material.dart';
//
// import '../common/entity/user.dart';
// import '../theme/text_styles.dart';
//
// class AppDropdownMenuItems {
//   static List<DropdownMenuItem<String>> rolesDropdownMenuItems= [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Select Your Role',
//         style: AppTextStyles.bodyMedium
//             .copyWith(
//           color: Colors
//               .grey, // Style the placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//         value: 'Admin', child: Text('Admin')),
//     DropdownMenuItem(
//         value: 'Caregiver', child: Text('Caregiver')),
//     DropdownMenuItem(
//         value: 'Caretaker', child: Text('Caretaker')),
//   ];
//   static List<DropdownMenuItem<String>> genderDropdownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose user gender',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style the placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'Male',
//       child: Text('Male'),
//     ),
//     DropdownMenuItem(
//       value: 'Female',
//       child: Text('Female'),
//     ),
//     DropdownMenuItem(
//       value: 'Other',
//       child: Text('Other'),
//     ),
//   ];
//   static List<DropdownMenuItem<String>> careNeedsDropdownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose Care Needed for Person',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style for placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'Medical Care',
//       child: Text('Medical Care'),
//     ),
//     DropdownMenuItem(
//       value: 'Daily Assistance',
//       child: Text('Daily Assistance'),
//     ),
//     DropdownMenuItem(
//       value: 'Emotional Support',
//       child: Text('Emotional Support'),
//     ),
//   ];
//   static List<DropdownMenuItem<String>> chooseAvailabilityDropDownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose Availability',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style for placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'Available',
//       child: Text('Available'),
//     ),
//     DropdownMenuItem(
//       value: 'Un-Available',
//       child: Text('Un-Available'),
//     ),
//   ];
//   static List<DropdownMenuItem<String>> chooseUserDropdownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose User',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style for placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'John Doe',
//       child: Text('John Doe'),
//     ),
//     DropdownMenuItem(
//       value: 'Will Smith',
//       child: Text('Will Smith'),
//     ),
//     DropdownMenuItem(
//       value: 'Chris Evans',
//       child: Text('Chris Evans'),
//     ),
//   ];
//   static List<DropdownMenuItem<String>> chooseTaskDropDownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose Task',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style for placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'Prepare Breakfast',
//       child: Text('Prepare Breakfast'),
//     ),
//     DropdownMenuItem(
//       value: 'Cleaning',
//       child: Text('Cleaning'),
//     ),
//     DropdownMenuItem(
//       value: 'Medicine',
//       child: Text('Medicine'),
//     ),
//   ];
//   static List<DropdownMenuItem<String>> chooseDocumentDropDownMenuItems = [
//     DropdownMenuItem(
//       value: null,
//       child: Text(
//         'Choose Document',
//         style: AppTextStyles.bodyMedium.copyWith(
//           color: Colors.grey, // Style for placeholder text
//         ),
//       ),
//     ),
//     DropdownMenuItem(
//       value: 'Employment Application',
//       child: Text('Employment Application'),
//     ),
//     DropdownMenuItem(
//       value: 'CPR Certificate',
//       child: Text('CPR Certificate'),
//     ),
//   ];
//
//   static List<DropdownMenuItem<String>> generateUserDropDown(List<User> userList) {
//     List<DropdownMenuItem<String>> items = [
//       DropdownMenuItem<String>(
//         value: null,
//         child: Text(
//           'Choose User'
//         ),
//       ),
//     ];
//
//     items.addAll(userList.map((user) {
//       return DropdownMenuItem<String>(
//         value: user.userId,
//         child: Text(user.userName),
//       );
//     }).toList());
//
//     return items;
//   }
//   static List<DropdownMenuItem<String>> generateTaskDropdown(List<DialogueBoxTask> userList) {
//     List<DropdownMenuItem<String>> items = [
//       DropdownMenuItem<String>(
//         value: null,
//         child: Text(
//           'Choose Task'
//         ),
//       ),
//     ];
//
//     items.addAll(userList.map((user) {
//       return DropdownMenuItem<String>(
//         value: user.taskId,
//         child: Text(user.taskName),
//       );
//     }).toList());
//
//     return items;
//   }
//
//
//
// }