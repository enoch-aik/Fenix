import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../theme.dart';
import '../typography.dart';
import '../widgets.dart';

class CustomDialogs {
  // showSuccessDialog({title, message, onClick}) {
  //   return Get.bottomSheet(
  //     Container(
  //       decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
  //       height: height() * 0.4,
  //       width: width(),
  //       padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             smallSpace(),
  //             Container(
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: AppColor.green.withOpacity(0.2),
  //               ),
  //               child: const Padding(
  //                 padding: EdgeInsets.all(20.0),
  //                 child: Icon(Icons.check, size: 30, color: AppColor.green),
  //               ),
  //             ),
  //             smallSpace(),
  //             if (title != null)
  //               Text(
  //                 title,
  //                 textAlign: TextAlign.center,
  //                 style: headingFontLarge(),
  //               ),
  //             tinySpace(),
  //             Text(
  //               message,
  //               textAlign: TextAlign.center,
  //               style: articleFontSmall(),
  //             ),
  //             mediumSpace(),
  //             DefaultButton(
  //               title: 'Great',
  //               onPress: onClick ??
  //                       () {
  //                     Get.back();
  //                   },
  //             ),
  //             smallSpace(),
  //           ],
  //         ),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //   );
  // }
  //
  // showFailedDialog({title, message, onClick}) {
  //   return Get.bottomSheet(
  //     Container(
  //       decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
  //       height: height() * 0.4,
  //       width: width(),
  //       padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             smallSpace(),
  //             Container(
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: AppColor.red.withOpacity(0.2),
  //               ),
  //               child: const Padding(
  //                 padding: EdgeInsets.all(20.0),
  //                 child: Icon(Icons.close, size: 30, color: AppColor.red),
  //               ),
  //             ),
  //             smallSpace(),
  //             if (title != null)
  //               Text(
  //                 title,
  //                 textAlign: TextAlign.center,
  //                 style: headingFontLarge(),
  //               ),
  //             tinySpace(),
  //             Text(
  //               message,
  //               textAlign: TextAlign.center,
  //               style: articleFontSmall(),
  //             ),
  //             mediumSpace(),
  //             DefaultButton(
  //               title: 'Great',
  //               onPress: onClick ??
  //                       () {
  //                     Get.back();
  //                   },
  //             ),
  //             smallSpace(),
  //           ],
  //         ),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //   );
  // }

  static showNoticeDialog(
      {title,
      message,
      closeText,
      okText,
      onClose,
      onClick,
      isMessageWidget = false}) {
    return Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        height: height() * 0.45,
        width: width(),
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                smallSpace(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: amber.withOpacity(0.2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(Icons.priority_high, size: 30, color: amber),
                  ),
                ),
                smallSpace(),
                if (title != null)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: articleFontMedium3(),
                  ),
                tinySpace(),
                isMessageWidget
                    ? message
                    : Text(
                        message,
                        textAlign: TextAlign.center,
                        style: articleFontSmall(),
                      ),
                mediumSpace(),
                DefaultButton(
                  title: okText ?? 'OK',
                  onPress: onClick ??
                      () {
                        Get.back();
                      },
                ),
                tinySpace(),
                TextButton(
                  child: Text(
                    closeText ?? 'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                  ),
                  onPressed: onClose ??
                      () {
                        Get.back();
                      },
                ),
                smallSpace(),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
