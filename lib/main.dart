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

// enum TipPercentageLabel {
//   t12('12', 0.12),
//   t15('15', 0.15),
//   t18('18', 0.18),
//   t20('20', 0.20);

//   const TipPercentageLabel(this.label, this.percentage);
//   final String label;
//   final double percentage;
// }

class _CalcFormState extends State<CalcForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tipController = TextEditingController();

  var tipOptions = [12, 15, 18, 20];

  double billAmount = 0.0;
  int tipPercentage = 15;

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

  // calculate the tip from the tipPercentage, billAmount.
  // updates tipAmount and totalAmount
  void _calculate() {
    setState(() {
      tipAmount = billAmount * (tipPercentage / 100);
      totalAmount = tipAmount + billAmount;
    });
  }

  @override
  void initState() {
    super.initState();
    tipController.addListener(() {
      final String item = tipController.value.text;

      //check if num
      if (item != "") {
        try {
          // calculate tip + total
          tipPercentage = int.parse(item);
          _calculate();
        } catch (e) {
          _formKey.currentState?.reset();
          tipController.value = const TextEditingValue(text: "15");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bill amount
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  initialValue: "",
                  onChanged: (value) => setState(() {
                    //check if num
                    if (value != "") {
                      try {
                        // calculate tip + total
                        billAmount = double.parse(value);
                        _calculate();
                      } catch (e) {
                        alert(context, "$value is not a number");
                        _formKey.currentState?.reset();
                      }
                    }
                  }),
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Bill \$"),
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
            ),
            // Tip %
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                child: DropdownMenu<int>(
                  initialSelection: 15,
                  controller: tipController,
                  label: const Text("Tip %"),
                  dropdownMenuEntries: [
                    ...tipOptions.map((int tpl) {
                      return DropdownMenuEntry<int>(
                        value: tpl,
                        label: "$tpl",
                      );
                    }),
                  ],
                ),
              ),
            ),
            // Display amounts
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount"),
                    Text("$totalAmount"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
