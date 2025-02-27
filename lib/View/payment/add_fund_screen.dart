import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

import '../../constants/text_form_field_label.dart';
import '../../utils/app_utils.dart';

class AddFundScreen extends StatefulWidget {
  const AddFundScreen({super.key, required this.data1});
  final String data1;

  @override
  State<AddFundScreen> createState() => _HomePageState();
}

class _HomePageState extends State<AddFundScreen> {
  final TextEditingController textController = TextEditingController();
  final form = GlobalKey<FormState>();

  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: widget.data1,
      receiverName: '',
      transactionRefId: '',
      transactionNote: '',
      amount: double.parse(textController.text.toString()),
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (apps!.isEmpty){
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    }
    else{
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: form,
                child: TextFormFieldLabel(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  lebelText: 'Add amount',
                  lebelFontColor: const Color(0xff1A1A1A),
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Add amount',
                  controller: textController,
                  // focusNode: signupVM.lastNameFocusNode.value,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return 'Enter amount';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 10,),
              Wrap(
                children: apps!.map<Widget>((UpiApp app) {
                  return GestureDetector(
                    onTap: () {
                      if(form.currentState!.validate()){
                        _transaction = initiateTransaction(app);
                        setState(() {});
                      }
                    },
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.memory(
                            app.icon,
                            height: 60,
                            width: 60,
                          ),
                          Text(app.name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException :
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException :
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException :
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException :
        return 'Requested app cannot handle the transaction (Invalid UPI Provider)';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        AppUtils.showSnackBar(title: 'Success', message: 'Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        AppUtils.showSnackBar(title: 'Submitted', message: 'Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        AppUtils.showSnackBar(title: 'Failed', message: 'Transaction Failed');
        break;
      default:
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
                body,
                style: value,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: displayUpiApps(),
          ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        textAlign: TextAlign.center,
                        style: header,
                      ),
                    );
                  }
                  UpiResponse upiResponse = snapshot.data!;
                  String txnId = upiResponse.transactionId ?? 'N/A';
                  String resCode = upiResponse.responseCode ?? 'N/A';
                  String txnRef = upiResponse.transactionRefId ?? 'N/A';
                  String status = upiResponse.status ?? 'N/A';
                  String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(status);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // displayTransactionData('Transaction Id', txnId),
                        // displayTransactionData('Response Code', resCode),
                        // displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        // displayTransactionData('Approval No', approvalRef),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
