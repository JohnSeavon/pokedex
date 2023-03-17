class Generation {
  final String generation;
  final int initialId;
  final int finalId;

  Generation(
    this.generation,
    this.initialId,
    this.finalId,
  );

  int get total => (finalId - initialId) + 1;
}
