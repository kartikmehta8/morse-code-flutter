import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'morseconvert.dart';
import 'package:morsecode/morse_page.dart';

class MorseTorch extends StatefulWidget {
  const MorseTorch({Key? key}) : super(key: key);

  @override
  State<MorseTorch> createState() => _MorseTorchState();
}

class _MorseTorchState extends State<MorseTorch> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String inputText = "";
  var encodeMorse = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text(
          'Morse Torch',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.code), // Icon for the button
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MorseCodePage()), // Navigate to the new page
              );
            },
          ),
        ],
      ),
        body: FutureBuilder<bool>(
          future: _isTorchAvailable(context),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Image.asset('assets/img1.png'),
                  const Spacer(),
                  Text(
                    encodeMorse,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Enter text to convert',
                        ),
                        onChanged: (val) {
                          setState(() => inputText = val);
                          encodeMorse = Morse().encode(val);
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                            elevation: .800
                        ),
                        child: const Text('Encode'),
                        onPressed: () async {
                          encodeMorse = Morse().encode(inputText);
                          // encodeMorse = encodeMorse + "x";
                          // encodeMorse.split("").forEach((ch) => ch == '.'
                          //     ? _enableMorseDit(context)
                          //     : ch == "-"
                          //         ? _enableMorseDaah(context)
                          //         : print("space"));
                          List<String> result = encodeMorse.split('');
                          // result.add("end");

                          for (var x in result) {

                            if (x == ".") {
                              await _enableMorseDit(context);
                            } else if (x == "-") {
                              await _enableMorseDaah(context);
                            } else {
                              await Future.delayed(const Duration(seconds: 1));
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              );
            } else if (snapshot.hasData) {
              return const Center(
                child: Text('No torch available.'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (err) {
      _showMessage(
        err.toString(),
        context,
      );
      rethrow;
    }
  }

  Future<void> _enableMorseDit(BuildContext context) async {
    try {
      if (kDebugMode) {
        print("dit");
      }
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(seconds: 1), () {});
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  Future<void> _enableMorseDaah(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(seconds: 3), () {});
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

dynamic textInputDecoration = InputDecoration(
  labelStyle: const TextStyle(
    color: Colors.black,
  ),
  fillColor: Colors.black,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(width: 1, color: Colors.black),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(width: 1, color: Colors.green),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(),
  ),
);
