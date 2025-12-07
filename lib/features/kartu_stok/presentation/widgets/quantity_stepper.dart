import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityStepper extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const QuantityStepper({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late TextEditingController _controller;
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller = TextEditingController(text: _value.toString());
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
      _controller.text = _value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() {
      _value++;
      _controller.text = _value.toString();
      widget.onChanged(_value);
    });
  }

  void _decrement() {
    if (_value > 0) {
      setState(() {
        _value--;
        _controller.text = _value.toString();
        widget.onChanged(_value);
      });
    }
  }

  void _onTextChanged(String value) {
    final intValue = int.tryParse(value);
    if (intValue != null && intValue >= 0) {
      setState(() {
        _value = intValue;
        widget.onChanged(_value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: IntrinsicWidth(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Color.fromARGB(255, 7, 117, 70)),
              onPressed: _decrement,
            ),
            SizedBox(
              width: 60,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: _onTextChanged,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Color.fromARGB(255, 7, 117, 70)),
              onPressed: _increment,
            ),
          ],
        ),
      ),
    );
  }
}
