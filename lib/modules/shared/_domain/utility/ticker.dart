class Ticker {
  const Ticker();

  Stream<int> tickBackward({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<int> tickForward({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x + 1)
        .take(ticks);
  }
}
