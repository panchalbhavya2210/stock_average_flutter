import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() => runApp(const StockAverageCalculatorApp());

class StockAverageCalculatorApp extends StatelessWidget {
  const StockAverageCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StockCalculator(),
    );
  }
}

class StockCalculator extends StatefulWidget {
  const StockCalculator({super.key});

  @override
  _StockCalculatorState createState() => _StockCalculatorState();
}

class _StockCalculatorState extends State<StockCalculator> {
  final TextEditingController _priceOne = TextEditingController();
  final TextEditingController _qtyOne = TextEditingController();
  final TextEditingController _priceTwo = TextEditingController();
  final TextEditingController _qtyTwo = TextEditingController();

  double _avgFinalCost = 0.0;

  void _avgCalculate() {
    final double priceOne = double.tryParse(_priceOne.text) ?? 0.0;
    final int qtyOne = int.tryParse(_qtyOne.text) ?? 0;
    final double priceTwo = double.tryParse(_priceTwo.text) ?? 0.0;
    final int qtyTwo = int.tryParse(_qtyTwo.text) ?? 0;

    final double totalCost = (priceOne * qtyOne) + (priceTwo * qtyTwo);
    final int totalQty = qtyOne + qtyTwo;

    setState(() {
      _avgFinalCost = totalQty != 0 ? totalCost / totalQty : 0.0;
    });
  }

  int _getTotalUnits() {
    final int qtyOne = int.tryParse(_qtyOne.text) ?? 0;
    final int qtyTwo = int.tryParse(_qtyTwo.text) ?? 0;
    return qtyOne + qtyTwo;
  }

  double _getTotalAmount() {
    final double priceOne = double.tryParse(_priceOne.text) ?? 0.0;
    final double priceTwo = double.tryParse(_priceTwo.text) ?? 0.0;
    return priceOne + priceTwo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Average Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "First Purchase Details",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                controller: _priceOne,
                decoration: const InputDecoration(
                    labelText: 'First Bought Price', filled: true),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _qtyOne,
                decoration: const InputDecoration(
                    labelText: 'First Bought Quantity', filled: true),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Second Purchase Details",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                controller: _priceTwo,
                decoration: const InputDecoration(
                    labelText: 'New Buying Price', filled: true),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _qtyTwo,
                decoration: const InputDecoration(
                    labelText: 'New Buying Quantity', filled: true),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _avgCalculate,
                child: const Text('Calculate Average'),
              ),
              const SizedBox(height: 20),
              Text(
                'Average Price: ₹${_avgFinalCost.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Total Units: ${_getTotalUnits()}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Total Amount: ₹${_getTotalAmount().toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceOne.dispose();
    _qtyOne.dispose();
    _priceTwo.dispose();
    _qtyTwo.dispose();
    super.dispose();
  }
}
