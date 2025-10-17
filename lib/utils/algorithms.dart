// Integer to English words

String numberToWords(int n, {bool hyphenateTens = false}) {
  if (n == 0) return 'zero';
  if (n < 0 || n > 999999999) {
    throw ArgumentError('number out of supported range 0..999,999,999');
  }

  final parts = <String>[];

  final millions = n ~/ 1000000;
  final thousands = (n ~/ 1000) % 1000;
  final rest = n % 1000;

  if (millions > 0) {
    parts.add(_threeDigitsToWords(millions, hyphenateTens));
    parts.add('million');
  }
  if (thousands > 0) {
    parts.add(_threeDigitsToWords(thousands, hyphenateTens));
    parts.add('thousand');
  }
  if (rest > 0) {
    parts.add(_threeDigitsToWords(rest, hyphenateTens));
  }

  return parts.join(' ');
}

String _threeDigitsToWords(int n, bool hyphenateTens) {
  assert(1 <= n && n <= 999);

  final units = [
    '', 'one', 'two', 'three', 'four', 'five',
    'six', 'seven', 'eight', 'nine'
  ];
  final teens = [
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen',
    'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
  ];
  final tens = [
    '', '', 'twenty', 'thirty', 'forty', 'fifty',
    'sixty', 'seventy', 'eighty', 'ninety'
  ];

  String twoDigitsToWords(int x) {
    if (x == 0) return '';
    if (x < 10) return units[x];
    if (x < 20) return teens[x - 10];
    final t = x ~/ 10;
    final u = x % 10;
    if (u == 0) return tens[t];
    final joiner = hyphenateTens ? '-' : ' ';
    return '${tens[t]}$joiner${units[u]}';
  }

  if (n < 100) return twoDigitsToWords(n);

  final h = n ~/ 100;
  final rem = n % 100;
  final head = '${units[h]} hundred';
  if (rem == 0) return head;
  final tail = twoDigitsToWords(rem);
  return '$head $tail';
}

// Nested sum
int sumNested(dynamic obj) {
  return switch (obj) {
    int n => n,
    double d => d.floor(),
    String s => sumAscii(s),
    List<dynamic> l => sumSpecialList(l),
    Map<dynamic, dynamic> m => _sumMapValues(m),

    (var a, var b) => sumPair((a, b)),
    (first: var a, second: var b) => sumPair((a, b)),

    _ => 0,
  };
}

int _sumMapValues(Map<dynamic, dynamic> m) {
  var total = 0;
  for (final v in m.values) {
    total += sumNested(v);
  }
  return total;
}

int sumAscii(String s) {
  var total = 0;
  for (final code in s.codeUnits) {
    if (code >= 0 && code <= 127) {
      total += code;
    }
  }
  return total;
}

int sumSpecialList(List<dynamic> l) {
  int loop(List<dynamic> xs, int acc) {
    if (xs case []) return acc;
    if (xs case [var head, ...var tail]) {
      return loop(tail, acc + sumNested(head));
    }

    var t = acc;
    for (final e in xs) {
      t += sumNested(e);
    }
    return t;
  }
  return loop(l, 0);
}

int sumPair((dynamic, dynamic) p) {
  final (a, b) = p;
  if (a case int x) {
    if (b case int y) return x + y;
  }
  return sumNested(a) + sumNested(b);
}
