import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackthisfall/data/auth.dart';
import 'package:hackthisfall/data/shared_preferesence.dart';
import 'package:hackthisfall/screens/home_screen.dart';
import 'package:hackthisfall/widgets/animated_btn.dart';
import 'package:hackthisfall/widgets/background.dart';
import 'package:phone_form_field/phone_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String userId, requestId;
  late final GlobalKey<FormState> _formKey;
  late final List<FocusNode> _focusNode;
  late final PhoneController _phoneController;
  late final TextEditingController nameController;
  late final List<TextEditingController> _otpController;
  bool getOTP = false;
  bool newUser = false;
  late final AuthApiClient _authApiClient;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _focusNode = List.generate(6, (index) => FocusNode());
    _phoneController = PhoneController(
        initialValue: const PhoneNumber(
      isoCode: IsoCode.IN,
      nsn: '',
    ));
    nameController = TextEditingController();
    _otpController = List.generate(4, (index) => TextEditingController());

    _authApiClient = AuthApiClient(Dio());

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.forEach((element) {
      element.dispose();
    });
    _phoneController.dispose();
    _otpController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackgroundGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Brainiacs",
              style: GoogleFonts.workSans(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * .1,
                vertical: screenSize.height * .15,
              ),
              child: Card(
                color: Colors.white24,
                elevation: 5.0,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: const Text("LOGIN"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Phone Number"),
                          PhoneFormField(
                            controller: _phoneController,
                            focusNode: _focusNode[0],
                            autofocus: true,
                            onSaved: (p0) {
                              _focusNode[0].unfocus();
                              _focusNode[1].requestFocus();
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your phone number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: newUser, child: const Text("Name")),
                          Visibility(
                            visible: newUser,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                hintText: "Enter your full name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              focusNode: _focusNode[1],
                              onFieldSubmitted: (value) {
                                _focusNode[1].unfocus();
                                _focusNode[2].requestFocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your full name";
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(visible: getOTP, child: const Text("OTP")),
                          Visibility(
                            visible: getOTP,
                            child: Row(
                              children: List.generate(
                                4,
                                (index) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: TextFormField(
                                      controller: _otpController[index],
                                      keyboardType: TextInputType.number,
                                      autofocus: true,
                                      // maxLength: 1,
                                      focusNode: _focusNode[index + 2],
                                      onChanged: (value) {
                                        _focusNode[index + 2].unfocus();
                                        if (index + 2 < 5) {
                                          _focusNode[index + 3].requestFocus();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: AnimButton(
                              tapOperation: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {});

                                  if (getOTP) {
                                    _formKey.currentState!.save();
                                    if (newUser) {
                                      String one = _otpController[0].text;
                                      String two = _otpController[1].text;
                                      String three = _otpController[2].text;
                                      String four = _otpController[3].text;
                                      final newUserResponse =
                                          VerifyOtpNameRequest(
                                        name: nameController.text,
                                        code: one + two + three + four,
                                        requestId: requestId,
                                        userId: userId,
                                      );
                                      _authApiClient
                                          .verifyOtpWithName(
                                              newUserResponse.toJson())
                                          .then((value) {
                                        SharedPref().storeValue(value.token);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(value.message)));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ));
                                      });
                                    } else {
                                      String one = _otpController[0].text;
                                      String two = _otpController[1].text;
                                      String three = _otpController[2].text;
                                      String four = _otpController[3].text;
                                      final userResponse = VerifyOtpRequest(
                                        code: one + two + three + four,
                                        requestId: requestId,
                                        userId: userId,
                                      );
                                      _authApiClient
                                          .verifyOtpWithName(
                                              userResponse.toJson())
                                          .then((value) {
                                        SharedPref().storeValue(value.token);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(value.message)));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ));
                                      });
                                    }
                                  } else {
                                    final authRequest = AuthRequest(
                                        phone:
                                            "91${_phoneController.value.nsn}");
                                    _authApiClient
                                        .authenticate(authRequest.toJson())
                                        .then((value) {
                                      userId = value.userId;
                                      requestId = value.requestId;
                                      if (value.status) {
                                        setState(() {
                                          newUser = true;
                                          getOTP = true;
                                        });
                                      } else {
                                        setState(() {
                                          getOTP = true;
                                        });
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(value.message)));
                                    });
                                  }
                                }
                              },
                              title: "L O G I N",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
                              //
