import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;

  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_7EFcyh0YmkHIE7",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "descriptionn": "Payment For the Random",
      "Profile": {
        "Contact": "+916200355931",
        "email": "samanish0003@gmail.com",
      },
      "external": {"Wallets": "paytm"}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    debugPrint("Payment success");
    // Toast.show("Payment success", context);
  }

  void handlerErrorFailure() {
    debugPrint("Payment Fail");
    // Toast.show("Payment Fail", context);
  }

  void handlerExternalWallet() {
    debugPrint("External Wallet");
    // Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'amount to pay',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Donnate Now",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                openCheckout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
