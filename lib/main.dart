import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tipr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        useMaterial3: true,
      ),
      home: const SafeArea(child: TiprHome()),
    );
  }
}

class TiprHome extends StatelessWidget {
  const TiprHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text("Tipr"),
      ),
      body: const Center(
        child: CalcForm(),
      ),
    );
  }
}

class CalcForm extends StatefulWidget {
  const CalcForm({super.key});

  @override
  State<CalcForm> createState() => _CalcFormState();
}

class _CalcFormState extends State<CalcForm> {
  final _formKey = GlobalKey<FormState>();

  double billAmount = 0.0;
  double tipPercentage = 0.15;

  var tipAmount = 0.0;
  var totalAmount = 0.0;

  /// alert will snow a snackbar
  void alert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: "",
                onChanged: (value) => setState(() {
                  //check if num
                  if (value != "") {
                    try {
                      // calculate tip + total
                      billAmount = double.parse(value);

                      tipAmount = billAmount * tipPercentage;
                      totalAmount = tipAmount + billAmount;
                    } catch (e) {
                      alert(context, "$value is not a number");
                      _formKey.currentState?.reset();
                    }
                  }
                }),
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter the bill amount",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    alert(context, "Enter something");
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 300,
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tip Amount"),
                  Text("$tipAmount"),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Amount"),
                  Text("$totalAmount"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
