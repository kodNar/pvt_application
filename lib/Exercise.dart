class Exercise{
  int _reps;
  int _sets;
  String _name;
  String _desc;

  int get reps => _reps;

  int get sets => _sets;

  String get desc => _desc;

  String get name => _name;

  Exercise(this._name, this._desc);

  void setSets(int value) {
    _sets = value;
  }

  void setReps(int value) {
    _reps = value;
  }

  String getName(){
    return _name;
  }

}