import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/get_all_todos.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/update_todo_status.dart';
import 'package:to_do_machine_test/features/todo/domain/usecase/upload_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UploadTodo _uploadTodo;
  final GetAllTodos _getAllTodos;
  final UpdateTodoStatus _updateTodoStatus;

  TodoBloc({
    required UploadTodo uploadTodo,
    required GetAllTodos getAllTodos,
    required UpdateTodoStatus updateTodoStatus,
  }) : _uploadTodo = uploadTodo,
       _getAllTodos = getAllTodos,
       _updateTodoStatus = updateTodoStatus,
       super(TodoInitial()) {
    on<TodoEvent>((event, emit) => emit(TodoLoading()));

    on<TodoUploadEvent>((event, emit) async {
      final res = await _uploadTodo(
        TodoParams(
          userId: event.userId,
          projectName: event.projectName,
          description: event.description,
          startDate: event.startDate,
          endDate: event.endDate,
          isCompleted: event.isCompleted,
        ),
      );

      res.fold(
        (failure) => emit(TodoFailure(failure.message)),
        (success) => emit(TodoUploadSuccess()),
      );
    });

    on<TodoGetAllTodoEvent>((event, emit) async {
      final res = await _getAllTodos();

      res.fold(
        (failure) => emit(TodoFailure(failure.message)),
        (success) => emit(TodoDisplaySuccess(success)),
      );
    });

    on<TodoMarkCompletedEvent>((event, emit) async {
      emit(TodoLoading());

      final res = await _updateTodoStatus(
        todoId: event.todoId,
        isCompleted: event.isCompleted,
      );

      res.fold(
        (failure) => emit(TodoFailure(failure.message)),
        (_) => add(TodoGetAllTodoEvent()), // refresh list
      );
    });
  }
}
