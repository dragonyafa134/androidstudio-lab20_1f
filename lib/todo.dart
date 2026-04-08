class Todo {
  static int _counter = 0;

  final int id;
  String titile;
  bool isDone;

  Todo(this.titile) : id = ++_counter, isDone = false;

  @override
  String toString() {
    String status;
    if(isDone) {
      status = '[x]';
    }else{
      status = '[ ]';
    }
    return '$status $id $titile';

  }

}