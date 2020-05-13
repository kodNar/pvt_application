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

  set sets(int value) {
    _sets = value;
  }

  set reps(int value) {
    _reps = value;
  }

  String getName(){
    return _name;
  }

}