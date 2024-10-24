package pl.jg.todo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.jg.todo.model.TodoEntity;

public interface TodoRepository extends JpaRepository<TodoEntity, Long> {

}

