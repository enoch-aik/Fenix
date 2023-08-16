import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/screens/profile/account/contact/contact_us.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/account_controller.dart';
import '../../../helpers/widgets/dialogs.dart';
import '../../onboarding/constants.dart';
import '../edit_profile.dart';
import 'account_info.dart';
import 'login_and_security.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Account extends StatelessWidget {
   Account({Key? key}) : super(key: key);

  final AccountController _accountController = Get.find();


  var refreshToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(

          // automaticallyImplyLeading: true,
        title: Text(
          AppLocalizations.of(context)!.yourAccount,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.w,
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(2, 2))
              ]),
        ),
          leading:  backArrow(),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 27.w,
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                refreshToken = prefs.getString('refreshToken');
                CustomDialogs.showNoticeDialog(
                    message: "${AppLocalizations.of(context)!.pleaseDontLeave} 😭",
                    image: "assets/images/icons/logout.png",
                    closeText: AppLocalizations.of(context)!.cancel,
                    okText: AppLocalizations.of(context)!.confirm,
                    onClick: () {
                      _accountController.signOut(refreshToken);
                    });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 27.w,
                ),
              ),
            ),
          ],
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          )),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              const Text('Account Settings'),
              smallSpace(),
              accountContainer(AppLocalizations.of(context)!.yourAccountInfo, onTap: () {
                Get.to(() => AccountInfo());
              }),
              tinySpace(),
              accountContainer(AppLocalizations.of(context)!.loginSecurity, onTap: () {
                Get.to(() => LoginAndSecurity());
              }),
              tinySpace(),
              accountContainer(AppLocalizations.of(context)!.contactUs, onTap: (){
                Get.to(() => ContactUs());
              }),
              mediumSpace(),
              const Text('Payment Settings'),
              smallSpace(),
              accountContainer(AppLocalizations.of(context)!.yourPayments),
              tinySpace(),
              accountContainer(AppLocalizations.of(context)!.yourGiftCard),
              tinySpace(),
              accountContainer(AppLocalizations.of(context)!.fenixCard),
            ],
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
