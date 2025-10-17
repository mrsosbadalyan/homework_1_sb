import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/algorithms.dart';

class NestedSumPage extends StatefulWidget {
  const NestedSumPage({super.key});

  @override
  State<NestedSumPage> createState() => _NestedSumPageState();
}

class _NestedSumPageState extends State<NestedSumPage> {
  late final TextEditingController _inputController;
  int _total = 0;
  String? _error;

  static const String _initialJson = '''
[
  1,
  [2, 3, 4],
  {"a": 5, "b": ["ab", 7]},
  {"first": 8, "second": "c"},
  {"c": {"first": 10, "second": ["xy", 12]}},
  "z",
  13.5,
  [14, {"d": 15, "e": {"first": "p", "second": 17}}]
]
''';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _initialJson);
    _compute(); // initial 
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _compute() {
    setState(() {
      _error = null;
      try {
        final dynamic data = jsonDecode(_inputController.text);

        _total = sumNested(data);
      } on FormatException catch (e) {
        _error = 'Invalid JSON: ${e.message}';
      } catch (e) {
        _error = 'Error: $e';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _inputController,
          maxLines: 12,
          decoration: const InputDecoration(
            labelText: 'Enter JSON (lists, maps, numbers, strings)',
            alignLabelWithHint: true,
            hintText: 'Example: ["ab", 7, {"first": 8, "second": "c"}]',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) {
          },
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _compute,
          icon: const Icon(Icons.refresh),
          label: const Text('Compute total'),
        ),
        const SizedBox(height: 12),
        if (_error != null)
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: ListTile(
              leading: const Icon(Icons.error_outline),
              title: Text(
                _error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          )
        else
          Card(
            child: ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Total'),
              subtitle: Text('$_total'),
            ),
          ),
        const SizedBox(height: 8),

      ],
    );
  }
}
