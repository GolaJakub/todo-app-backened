package pl.jg.todo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Data;

@Entity
@Data
public class TodoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private boolean completed;
    private boolean priority;
    private LocalDateTime dateAdded;

    public TodoEntity() {
        this.dateAdded = LocalDateTime.now();
    }
}

