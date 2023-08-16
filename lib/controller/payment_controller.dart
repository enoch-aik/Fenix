
import 'package:fenix/screens/profile/wallets/otpVerification.dart';
import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/payment_services.dart';
import '../screens/profile/subscribe/plans.dart';
import '../screens/views.dart';



class PaymentController extends GetxController{

  var userCards;

  Rx<bool> paymentStatus = false.obs;

  RxBool processing = false.obs;

  RxList planList = [].obs;

  RxBool isGettingPlans = false.obs;

  createUserCard(
      {cardNumber, expiryDate, token}) {
    PaymentServices.createCard((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', response["message"]);
        Get.to(() => VerifyCode(time: 60000, message:  response["message"]));
      } else {
        // Get.back();

        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
      "number": "8600069195406311",
      "expire": "0399"
    }, token);
  }

    getUserCards(
        {token}) {
      PaymentServices.getCards((status, response) {
        print(response);
        if (status) {
          CustomSnackBar.successSnackBar(
              'Success', 'All cards gotten');
        print(response);
        userCards = response['data'];
        } else {
          // Get.back();
          CustomSnackBar.failedSnackBar('Failed', '$response');
        }
      }, token);
    }


  verifyOTP(
      {code, token}) {
    paymentStatus = false.obs;
    PaymentServices.verifyOTP((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'OTP has been verified');
        paymentStatus = true.obs;
      } else {
        // Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
      "code": "666666"
    }, token);
  }

  resendOTP(
      {token}) {
    PaymentServices.resendOTP((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'OTP has been sent again');

      } else {
        // Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {}, token);
  }



  pay(
      {amount, itemId, planId, couponCode, banner, token}) {
    print(itemId);
    PaymentServices.initialisePayment((status, response) {
      print(response);
     processing.value = true;
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', response["message"]);
        processing.value = false;
        paymentStatus = false.obs;
        // Get.off(() => Views());
      } else {

        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, (couponCode == null && banner == null) ? {
      "itemId": itemId,
      "planId": planId,
    } : (couponCode != null && banner == null) ? {
      "itemId": itemId,
      "planId": planId,
      "couponCode": couponCode,
    } :  (couponCode == null && banner != null) ? {
      "itemId": itemId,
      "planId": planId,
      "banner": banner,
    }: {
      "itemId": itemId,
      "planId": planId,
      "couponCode": couponCode,
      "banner": banner,
    }, token);
  }


  getPlans(
      {token, planType}) {
    isGettingPlans(true);
    PaymentServices.getPlans((status, response) {
      print(response);
      if (status) {
        planList.value = response['data'];
        Get.to(() => Plans(
          type: "$planType Plan ${planName(planType)}",
          planType: planName(planType),
          planTarget: planTarget(planType),
          planDetails: planList,
        ));
        CustomSnackBar.successSnackBar(
            'Success', 'Plan Gotten');
        isGettingPlans(false);
      } else {
        // Get.back();
        isGettingPlans(false);
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, planType);
  }

  String planName(type){
    var name = '';
    (type == "platinum") ? name = "Top Banner"
        : (type == "diamond") ? name = "Top 10"
        : (type == "gold") ? name = "Best Selling"
        : (type == "silver") ? name = "Top Deals"
        : name = "Recommended Deals";
    return name;
  }

  String planTarget(type){
    var target = '';
    (type == "platinum") ? target = "Fast Sale"
        : (type == "diamond") ? target = "Unlimited Post"
        : (type == "gold") ? target = "Unlimited Post"
        : (type == "silver") ? target = "Top Promote"
        : target = "Affordable price";
    return target;
  }


// deleteItemFromWishList(token, productId, category) async {
  //
  //   PaymentServices.removeCard((status, response) {
  //
  //     if (status) {
  //
  //       CustomSnackBar.successSnackBar('Cool', 'Card Deleted');
  //       getUserCards(token: token);
  //     } else {
  //       CustomSnackBar.failedSnackBar('Failed', '$response');
  //     }
  //   }, token);
  // }


}