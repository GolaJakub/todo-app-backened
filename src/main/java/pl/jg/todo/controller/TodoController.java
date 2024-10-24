package pl.jg.todo.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.jg.todo.model.TodoEntity;
import pl.jg.todo.service.TodoService;

@RestController
@RequestMapping("/api/todos")
@RequiredArgsConstructor
public class TodoController {

    @GetMapping
    public List<TodoEntity> getAllTodos() {
        return todoService.getAllTodos();
    }

    @PostMapping
    public TodoEntity addTodo(@RequestBody TodoEntity todo) {
        return todoService.addTodo(todo);
    }

    @PatchMapping("/{id}")
    public TodoEntity updateTodoStatus(@PathVariable Long id, @RequestParam boolean completed) {
        return todoService.updateTodoStatus(id, completed);
    }

    @DeleteMapping("/{id}")
    public void deleteTodoById(@PathVariable Long id) {
        todoService.deleteTodoById(id);
    }

    private final TodoService todoService;
}

