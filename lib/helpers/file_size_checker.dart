// import 'dart:io';
//
// import 'package:doctor_appointment/helpers/toast_message_helper.dart';
//
// class FileSizeChecker {
//   /// Check if a file's size is within the specified limit
//  static bool isFileSizeWithinLimit(File? file, int sizeInMB) {
//     if (file == null) return false; // No file selected
//     final fileSize = file.lengthSync();
//     final maxSizeInBytes = sizeInMB * 1024 * 1024; // Convert MB to Bytes
//     return fileSize <= maxSizeInBytes;
//   }
//
//   /// Check file size and display a message
//  static  checkFileSize(File? selectedImage) {
//     const sizeLimit = 5; // Size in MB
//     if (isFileSizeWithinLimit(selectedImage, sizeLimit)) {
//       // ToastMessageHelper.showToastMessage("File size is within limit.");
//       print("File size is within limit.");
//     } else {
//       ToastMessageHelper.showToastMessage("File size exceeds the $sizeLimit MB limit.");
//       print("File size exceeds the $sizeLimit MB limit.");
//     }
//   }
// }
