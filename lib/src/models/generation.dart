class Generation {
  int generation;
  int initialId;
  int finalId;

  Generation(
    this.generation,
    this.initialId,
    this.finalId,
  );

  int get total => (finalId - initialId) + 1;
}
