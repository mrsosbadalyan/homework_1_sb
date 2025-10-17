import 'package:flutter/material.dart';
import '../utils/algorithms.dart';

class NumberToWordsPage extends StatefulWidget {
  const NumberToWordsPage({super.key});

  @override
  State<NumberToWordsPage> createState() => _NumberToWordsPageState();
}

class _NumberToWordsPageState extends State<NumberToWordsPage> {
  final _controller = TextEditingController(text: '1234567');
  bool _hyphenate = false;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _convert() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) {
      setState(() => _output = '');
      return;
    }

    final digitsOnly = RegExp(r'^\d{1,8}$');
    if (!digitsOnly.hasMatch(txt)) {
      setState(() => _output = 'enter a valid number from 0 to 99999999');
      return;
    }
    final n = int.parse(txt);
    final words = numberToWords(n, hyphenateTens: _hyphenate);
    setState(() => _output = words);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter integer (0..99,999,999)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.numbers),
          ),
          onChanged: (_) => _convert(),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: _hyphenate,
          onChanged: (v) {
            setState(() => _hyphenate = v);
            _convert();
          },
          title: const Text('Hyphenate tens (e.g., "twenty-one")'),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            _exButton(''),
            _exButton('6'),
            _exButton('42'),
            _exButton('123'),
            _exButton('900'),
            _exButton('8379'),
            _exButton('1234567'),
            _exButton('1000000'),
            _exButton('99999999'),
          ],
        ),
      ],
    );
  }

  Widget _exButton(String v) {
    return OutlinedButton(
      onPressed: () {
        _controller.text = v;
        _convert();
      },
      child: Text(v),
    );
  }
}
