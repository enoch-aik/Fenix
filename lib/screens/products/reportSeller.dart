import 'package:fenix/const.dart';
import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/dialogs.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/user_controller.dart';
import '../../controller/product_controller.dart';
import '../onboarding/constants.dart';

class ReportSeller extends StatelessWidget {
  var vendorId;

  ReportSeller({Key? key, this.vendorId}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ProductController productController = Get.find();

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title:  Text(
            "Report Issue/Seller",
            style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20.w,
                shadows: [
                  Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(2, 2))
                ]),
          ),
          leading:  InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),

          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          )),
      body: Column(
        children: [

          Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSpace(0.05),

                        TextFieldWidget(
                          hint: "Subject",
                          textController: subjectController,
                          validator: (value) => FieldValidator.validate(value!),
                        ),
                        kSpacing,
                        TextFieldWidget(
                            hint: "Description(describe the issue you had with this seller or product)",
                            textController: descriptionController,
                            maxLine: 8,
                          validator: (value) => FieldValidator.validate(value!),
                           ),
                        verticalSpace(0.3),
                       Obx(() => (productController.isSendingReport.value == false && productController.isReportSent.value == false) ? DefaultButton(
                         title: 'Send Report',
                         onPress: () {
                           if (_formKey.currentState!.validate()) {
                             productController.reportSeller(
                               vendorId: vendorId,
                               subject: subjectController.text,
                               description: descriptionController.text,
                             );
                           }
                         },
                       ) :  (productController.isSendingReport.value == true && productController.isReportSent.value == false)
                           ? CircularProgressIndicator.adaptive()
                           : DefaultButton(
                           title: 'Sent',
                           onPress: () {
                             Get.back();
                           }
                       ))
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  InkWell accountContainer(title, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration:
        depressNeumorph().copyWith(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    title,
                    style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  )),
              const Icon(Icons.arrow_forward, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
