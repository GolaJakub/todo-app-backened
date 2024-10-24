package pl.jg.todo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import pl.jg.todo.model.TodoEntity;
import pl.jg.todo.repository.TodoRepository;

@Service
@RequiredArgsConstructor
public class TodoService {

    public List<TodoEntity> getAllTodos() {
        return todoRepository.findAll();
    }

    public TodoEntity addTodo(TodoEntity todo) {
        return todoRepository.save(todo);
    }

    public TodoEntity updateTodoStatus(Long id, boolean completed) {
        TodoEntity todo = todoRepository.findById(id).orElseThrow();
        todo.setCompleted(completed);
        return todoRepository.save(todo);
    }

    public void deleteTodoById(Long id) {
        todoRepository.deleteById(id);
    }

    private final TodoRepository todoRepository;
}

