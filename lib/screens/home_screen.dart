import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_application/constant/colors.dart';
import 'package:timer_application/constant/strings.dart';
import 'package:timer_application/provider/timer_provider.dart';
import 'package:timer_application/widgets/button.dart';
import 'package:timer_application/widgets/textfield.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _secondController;
  late TextEditingController _minuteController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for minute and second input
    _secondController = TextEditingController();
    _minuteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      // Provide the TimerProvider to the widget tree
      create: (context) => TimerProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: blue,
            title: const Text(
              appBarTitle,
              style: TextStyle(color: white),
            ),
          ),
          body: SingleChildScrollView(
            child: Consumer<TimerProvider>(
              builder: (context, timerProvider, _) {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * .15,
                    ),
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 195, 212, 226),
                      radius: 60,
                      child: Center(
                        child: Text(
                          // Display the formatted time from the TimerProvider
                          '${timerProvider.formattedTime}',
                          style: const TextStyle(
                            color: black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: size.width *0.45,
                          child: buildButton(
                            onPressed: () {
                              // Show a dialog to set the timer duration
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: AlertDialog(
                                        title: const Text(setTimerButtonText),
                                        content: SizedBox(
                                          height: size.height *.2,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child:
                                                        buildTextFieldWithIcon(
                                                      controller:
                                                          _minuteController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      hintText: minuteHint,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 80,
                                                    child:
                                                        buildTextFieldWithIcon(
                                                      controller:
                                                          _secondController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      hintText: secondHint,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          buildButton(
                                            onPressed: () {
                                              // Close the dialog when cancel button is pressed
                                              Navigator.of(context).pop();
                                            },
                                            label: cancelButton,
                                            color: blue,
                                          ),
                                          buildButton(
                                              onPressed: () {
                                                // Validate and parse the input
                                                int seconds = int.tryParse(
                                                        _secondController
                                                            .text) ??
                                                    0;
                                                int minutes = int.tryParse(
                                                        _minuteController
                                                            .text) ??
                                                    0;

                                                // Set the timer duration based on user input
                                                timerProvider.setTimerDuration(
                                                    seconds, minutes);
                                                // Close the dialog when set button is pressed
                                                Navigator.of(context).pop();
                                              },
                                              label: setTimerButtonText,
                                              color: blue),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            label: setTimerButtonText,
                            color: blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: buildButton(
                            onPressed: timerProvider.startEnable
                                ? () {
                                    // Start the timer when the "Start" button is pressed
                                    timerProvider.startTimer();
                                  }
                                : null,
                            label: startTimerButton,
                            color: green,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.45,
                          child: buildButton(
                            onPressed: timerProvider.stopEnable
                                ? timerProvider.stopTimer
                                : null,
                            label: stopTimerButton,
                            color: grey,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
