extension SplitString on String {
  List<String> splitByLength(int length) {
    if (length == 0) throw Exception("Split By Length 0");

    List<String> partition = [];
    int i = 0;
    length = length > 0 ? length : -length;

    while ((i + 1) * length < this.length) {
      partition.add(substring(i * length, (i + 1) * length));

      i++;
    }
    if (i * length != this.length) {
      partition.add(substring(i * length));
    }

    return partition;
  }
}

extension SplitList<T> on List<T> {
  List<List<T>> splitByLength(int length) {
    if (length == 0) throw Exception("Split By Length 0");

    List<List<T>> partition = [];
    int i = 0;
    length = length > 0 ? length : -length;

    while ((i + 1) * length < this.length) {
      partition.add(sublist(i * length, (i + 1) * length));

      i++;
    }
    if (i * length != this.length) {
      partition.add(sublist(i * length));
    }

    return partition;
  }
}

extension CheckDuplicates on List {
  bool isUnique() {
    final list = this;
    var appearedElements = [];
    for (int i = 0; i < length; i++) {
      if (appearedElements.contains(list[i])) return false;
      appearedElements.add(list[i]);
    }
    return true;
  }
}
