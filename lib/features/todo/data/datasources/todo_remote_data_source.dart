import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_machine_test/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodoModel> uploadTodo(TodoModel todo);

  Future<List<TodoModel>> getAllTodos();

  Future<void> updateTodoStatus({
    required String todoId,
    required bool isCompleted,
  });
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final SupabaseClient supabaseClient;

  TodoRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<TodoModel> uploadTodo(TodoModel todo) async {
    try {
      final todoData = await supabaseClient
          .from('todos')
          .insert(todo.toJson())
          .select()
          .single();

      return TodoModel.fromJson(todoData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final todos = await supabaseClient
          .from('todos')
          .select('*,profiles (id)')
          .order('updated_at', ascending: false);

      return todos.map((todo) => TodoModel.fromJson(todo)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateTodoStatus({
    required String todoId,
    required bool isCompleted,
  }) async {
    await supabaseClient
        .from('todos')
        .update({'is_completed': isCompleted})
        .eq('id', todoId);
  }
}
