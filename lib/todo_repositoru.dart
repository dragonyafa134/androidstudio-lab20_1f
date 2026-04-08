import 'todo.dart';

class TodoRepositoru {
  final List<Todo> _todos = [];

  List<Todo> getAll() {
    return _todos;
  }

  void add(String titile) {
    if (titile.trim().isEmpty) {
      throw ArgumentError('Название задачи не может быть пустым');
    }
    Todo todo = Todo(titile.trim());
    _todos.add(todo);
  }

  void complete(int id) {
    for (var todo in _todos) {
      if (todo.id == id) {
        todo.isDone = true;
        return;
      }
    }
    throw ArgumentError('Задача с $id не найдун');
  }


  void delete(int id){
    for(int i = 0; i< _todos.length; i++){
      if(_todos[i].id == id){
        _todos.removeAt(i);
        return;
      }
    }
    throw ArgumentError('Задача с $id не найдун');
  }
}
