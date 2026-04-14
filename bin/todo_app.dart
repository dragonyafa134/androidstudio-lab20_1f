import 'dart:io';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_repositoru.dart';
import 'package:ansicolor/ansicolor.dart';



final AnsiPen greenPen = AnsiPen()..green();
final AnsiPen redPen = AnsiPen()..red();
final AnsiPen bluePen = AnsiPen()..blue();
final AnsiPen yellowPen = AnsiPen()..yellow();

void main() {
  TodoRepositoru repo = TodoRepositoru();
  printMenu();
  while (true) {
    stdout.write('> ');
    String? input = stdin.readLineSync();
    if (input == null) {
      continue;
    }
    input = input.trim();
    if (input.isEmpty) {
      continue;
    }
    bool shouldExit = handleCommand(repo, input);

    if (shouldExit) {
      break;
    }
  }

  // print('Hello world');
  // String name = 'Руна';
  // String? name2 = null;
  // var count = 0;
  // var titile = 'Учить rust';
  // var x = 5;
  // x = 'hello';

  // final id = 5; //неизменняемая

  // final id;
  // id = 5;

  // const appName = 'TodoApp';

  // print('$name, $name2, ${count + 5}, $titile, $appName, $id, $x');

  // List<String> tags = ['Инсту' , 'дом'];
  // Map<String, dynamic> data = {'key': 'value', 'num' : 10};
  // Set<int> numbers = {1,2,3,4,5,6,7};

  // String greet(String name) => 'Hello $name';

  // printTodo(titile: "купить");
  // printTodo(titile: "сделать дз", done: true);
}

bool handleCommand(TodoRepositoru repo, String input) {
  List<String> parts = input.split(' ');
  String command = parts[0].toLowerCase();
  try{
    switch (command){
      case "add":
        addCommand(repo, input);
        break;
      case "list":
        listCommand(repo);
        break;
      case "done":
        doneCommand(repo, parts);
        break;
      case "delete" :
        deleteCommand(repo, parts);
        break;
      case "exit":
        print(bluePen("Выход из программы"));
        return true;
      default:
        print("Неизвестная команда");
    }
  }
  catch (e) {
    print(redPen("Ошибка $e"));
  }
  return false;
}

void printMenu() {
  print(yellowPen("Приложенеия туду"));
  print('Команды');
  print(' add <текст>      -добавить задачу');
  print(' list             -показать список');
  print(' done <id>        -отметить выполнения');
  print(' delete <id>      -удалить задсчу');
  print(' exit             -вызож');
  print('');
}

void addCommand(TodoRepositoru repo, String input) {
  if (input.length <= 4) {
    print('Ошибка введите текст');
    return;
  }

  String title = input.substring(4).trim();
  repo.add(title);

  print('Задача добавлена');
}

void listCommand(TodoRepositoru repo) {
  List<Todo> todos = repo.getAll();
  if (todos.isEmpty) {
    print('список задач пуст');
    return;
  }
  for (var todo in todos) {
    print(todo);
  }
}

void doneCommand (TodoRepositoru repo, List<String> parts){
  if (parts.length < 2){
    print("Ошибка укажити id");
    return;
  }
  int id = int.parse(parts[1]);
  repo.complete(id);
  print("Задача отмечана выполненной");
}


void deleteCommand (TodoRepositoru repo,List<String> parts){
  if (parts.length < 2){
    print("Ошибка укажите id");
    return;
  }
  int id = int.parse(parts[1]);
  repo.delete(id);
  print("задача удалена");
}
// void printTodo({required String titile, bool done = false}) {
//   print('${done ? '+' : '-'} $titile');

// }

// class Todo{
//   final int id;
//   String titile;
//   bool isDone;

//   Todo({required this.id, required this.titile, this.isDone = false});
// }
