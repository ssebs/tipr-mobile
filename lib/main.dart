import 'package:flutter/material.dart';

/// main function
void main() {
  runApp(const TiprHome());
}

/// Home widget with theme info, appbar, etc.
class TiprHome extends StatelessWidget {
  const TiprHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tipr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade700,
            title: const Text(
              "Tipr",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: const CalcForm(),
        ),
      ),
    );
  }
}

enum TipOption {
  fifteen(value: 15, label: "15%"),
  eighteen(value: 18, label: "18%"),
  twenty(value: 20, label: "20%"),
  twentytwo(value: 22, label: "22%");

  const TipOption({required this.value, required this.label});
  final num value;
  final String label;
}

/// Calculator form state + functionality + rendering
class _CalcFormState extends State<CalcForm> {
  // final _formKey = GlobalKey<FormState>();
  TipOption tipO = TipOption.fifteen;
  final TextEditingController tipController = TextEditingController();

  // user will change these
  double billAmount = 0.0;
  num tipPercentage = 15;

  // these will be calculated
  double tipAmount = 0.0;
  double totalAmount = 0.0;

  // calculate the tip from the tipPercentage, billAmount.
  // updates tipAmount and totalAmount
  void _calculate() {
    setState(() {
      tipAmount = billAmount * (tipPercentage / 100);
      totalAmount = tipAmount + billAmount;

      // todo: implement "nearest rounded totalAmount"
    });
  }

  /// sets the bill amount, then calculates
  void _setBillAmount(String value) {
    // Make sure value is a number
    if (value.isEmpty) {
      return;
    }

    try {
      double dValue = double.parse(value);

      // Then update billAmount & calc
      setState(() {
        billAmount = dValue;
        _calculate();
      });
    } catch (e) {
      alert(context, "$value is not a number!");
    }
  }

  /// sets the tip %, then calculates
  void _setTipPercentage(TipOption option) {
    if (option.value == 0) {
      return;
    }

    // Update tipPercentage & calc
    setState(() {
      tipPercentage = option.value;
      _calculate();
      tipO = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Bill amount box
        Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                // Bill amount textbox
                SizedBox(
                  width: 200,
                  child: TextField(
                    onChanged: _setBillAmount,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      hintText: "Bill Amount",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tip percentages
        Center(
          child: SizedBox(
            width: 400,
            child: Column(children: [
              // "tip"
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tip %",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),

              // tip option buttons
              SegmentedButton<TipOption>(
                segments: <ButtonSegment<TipOption>>[
                  ButtonSegment<TipOption>(
                    value: TipOption.fifteen,
                    label: Text(TipOption.fifteen.label),
                  ),
                  ButtonSegment<TipOption>(
                    value: TipOption.eighteen,
                    label: Text(TipOption.eighteen.label),
                  ),
                  ButtonSegment<TipOption>(
                    value: TipOption.twenty,
                    label: Text(TipOption.twenty.label),
                  ),
                  ButtonSegment<TipOption>(
                    value: TipOption.twentytwo,
                    label: Text(TipOption.twentytwo.label),
                  ),
                ],
                selected: <TipOption>{tipO},
                onSelectionChanged: (Set<TipOption> p0) {
                  _setTipPercentage(p0.first);
                  tipO = p0.first;
                },
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll<TextStyle>(
                    theme.textTheme.bodyLarge!,
                  ),
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.all(20),
                  ),
                ),
              )
            ]),
          ),
        ),

        // Calculated values
        Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            width: 400,
            color: Colors.green,
            child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white, fontSize: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // tip amount
                    Column(
                      children: [
                        const Text("Tip amount"),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                tipAmount.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    // bill total
                    Column(
                      children: [
                        const Text("Bill total"),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                totalAmount.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),

        // Reset btn
      ],
    );
  }
}

/// Calculator form skel
class CalcForm extends StatefulWidget {
  const CalcForm({super.key});

  @override
  State<CalcForm> createState() => _CalcFormState();
}

/// alert will snow a snackbar
void alert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
