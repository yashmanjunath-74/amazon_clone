import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/AddressScreen';

  final String totalamount;

  const AddressScreen({super.key, required this.totalamount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];

  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalamount,
        label: 'Total amount ',
        status: PaymentItemStatus.final_price));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    print('Fetched address: $address');

    String addressToBeUsed = "";

    void payPressed(String addressFromProvider) {
      addressToBeUsed = "";
      bool isForm = flatBuildingController.text.isNotEmpty ||
          areaController.text.isNotEmpty ||
          pincodeController.text.isNotEmpty ||
          cityController.text.isNotEmpty;

      if (isForm) {
        if (_addressFormKey.currentState!.validate()) {
          addressToBeUsed =
              '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        } else {
          throw Exception('Please enter all the values!');
        }
      } else if (addressFromProvider.isNotEmpty) {
        addressToBeUsed = addressFromProvider;
      } else {
        showSnackBar(context, 'ERROR');
      }
      print('Address to be used: $addressToBeUsed');
    }

    void onGooglePayResult(res) {
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .address
          .isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: addressToBeUsed);

        addressServices.placeOrder(
            context: context,
            address: addressToBeUsed,
            totalSum: double.parse(widget.totalamount));
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  //color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  width: double.infinity,
                  child: Text(
                      address.isNotEmpty ? address : 'No address available'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: Text('OR'),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: <Widget>[
                    CustomTextfield(
                        controller: flatBuildingController,
                        hintText: 'Flat,House no , Building'),
                    const SizedBox(height: 10),
                    CustomTextfield(
                        controller: areaController, hintText: 'Area,Street'),
                    const SizedBox(height: 10),
                    CustomTextfield(
                        controller: pincodeController, hintText: 'Pincode'),
                    const SizedBox(height: 10),
                    CustomTextfield(
                        controller: cityController, hintText: 'TownCity'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<PaymentConfiguration>(
                future: PaymentConfiguration.fromAsset('gpay.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          GooglePayButton(
                            onPressed: () => payPressed(address),
                            width: double.infinity,
                            paymentConfiguration: snapshot.data!,
                            paymentItems: paymentItems,
                            type: GooglePayButtonType.buy,
                            buttonProvider: PayProvider.google_pay,
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            onPaymentResult: onGooglePayResult,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              payPressed(address);
                              onGooglePayResult(null);
                            },
                            child: Text('Cash on Delivery',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(double.infinity, 50),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error loading payment configuration');
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }
}
