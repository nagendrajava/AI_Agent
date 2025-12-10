# springboot-mapstruct

"Simplify DTO to Entity mapping with speed and type safety."

MapStruct is a Java annotation processor that generates type-safe and performant mappers for bean-to-bean conversion. If you’re building REST APIs with Spring Boot and want to keep your service layer free of boilerplate mapping logic — MapStruct is your best friend.

This project demonstrates a minimal, real-world example using:
- Spring Boot
- MapStruct
- DTO → Entity → DTO conversion
- REST APIs

📂 Full working example: https://github.com/nagendrajava/AI_Agent/tree/master/springboot-mapstruct

---

## Why MapStruct?

In traditional projects, mapping between DTOs and Entities requires a lot of repetitive code. MapStruct helps by providing:

- No manual setter/getter boilerplate
- Compile-time checked mappings (type safety)
- High performance (annotation-processor based, no reflection)

---

## Project Overview

Key components in this example:
- `User` (JPA Entity)
- `UserDTO` (Data Transfer Object)
- `UserMapper` (MapStruct @Mapper interface)
- `UserService` (business logic)
- `UserController` (REST endpoints)

---

## Step-by-Step

### 1) Entity — `User.java`
```java
@Entity
public class User {
    @Id
    @GeneratedValue
    private Long id;
    private String name;
    private String email;

    // getters and setters
}
```

### 2) DTO — `UserDTO.java`
```java
public class UserDTO {
    private String name;
    private String email;

    // getters and setters
}
```

### 3) Mapper — `UserMapper.java`
```java
@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDto(User user);
    User toEntity(UserDTO userDto);
}
```

When you compile the project, MapStruct generates an implementation (e.g. `UserMapperImpl`) automatically.

### 4) Service — `UserService.java`
```java
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserMapper userMapper;

    public UserDTO save(UserDTO userDto) {
        User user = userMapper.toEntity(userDto);
        return userMapper.toDto(userRepository.save(user));
    }

    public List<UserDTO> getAll() {
        return userRepository.findAll()
                             .stream()
                             .map(userMapper::toDto)
                             .collect(Collectors.toList());
    }
}
```

### 5) Controller — `UserController.java`
```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping
    public ResponseEntity<UserDTO> create(@RequestBody UserDTO userDto) {
        return ResponseEntity.ok(userService.save(userDto));
    }

    @GetMapping
    public List<UserDTO> getAllUsers() {
        return userService.getAll();
    }
}
```

---

## Maven Configuration

Add MapStruct and the processor to your `pom.xml`:

```xml
<dependencies>
    <!-- MapStruct -->
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct</artifactId>
        <version>1.5.5.Final</version>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.11.0</version>
            <configuration>
                <source>17</source>
                <target>17</target>
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                        <version>1.5.5.Final</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
```

---

## Run & Test the API

Start the Spring Boot application and test endpoints (e.g., with curl or Postman).

POST /api/users
```json
{ "name": "Nagendra", "email": "nagendra@example.com" }
```

GET /api/users
```json
[ { "name": "Nagendra", "email": "nagendra@example.com" } ]
```

---

## Benefits of Using MapStruct

- Fast performance (no reflection)
- Type safety at compile time
- Less boilerplate mapping code
- Seamless Spring integration (`@Mapper(componentModel = "spring")`)

---

## Contributing

Contributions, issues and feature requests are welcome. Feel free to open a PR or an issue in the repository.

---

## Links

- Repository: https://github.com/nagendrajava/AI_Agent/tree/master/springboot-mapstruct

---

## License

See the repository `LICENSE` file for license details.

---

If you want, I can also:
- Add a full `pom.xml` and example `application.properties`
- Provide unit tests for the mapper
- Show how to map nested objects and collections with MapStruct

Enjoy — and happy mapping! 🚀
```
