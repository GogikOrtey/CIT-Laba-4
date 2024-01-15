## Выполненные шаги, по реализации задания 4 по Сетевым

### Установка Nginx

```
sudo apt update
sudo apt install nginx
```

Запуск Nginx

```
sudo systemctl start nginx
```

Проверка статуса служб Nginx

```
sudo systemctl status nginx
```

Проверка конфигурации Nginx

```
sudo nginx -t
```

---

Изменяем конфигурацию Nginx, что бы он был доступен с localhost

```
sudo nano /etc/nginx/nginx.conf
```

Добавляем нужный блок, <u>внутрь блока http</u>

```bash
server {
    listen 700;
    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }
}
```

Сохраняем файл

Проверяем конфигурацию

```
sudo nginx -t
```

Перезагружаем Nginx

```
sudo systemctl restart nginx
```

Теперь по адресу 

```
http://localhost:700/
```

Можно будет найти приветственное сообщение Nginx.

С этим закончили, идём дальше

---

### Symfony_and_Doctrine

Установка **Symfony + Doctrine**

Symfony устанавливается через composer, сначала скачиваем его:

```
apt install composer
```

Создаём новую папку, для хранения проекта Symfony + Doctrine. Переходим в неё

Нужно выполнять эти команды от имени обычного пользователя, а не от имени суперпользователя.

Может пригодится:

```
sudo chmod 777 Symfony_and_Doctrine_2
```

*Symfony_and_Doctrine* - так я назвал директорию, для всех этих проектов

Устанавливаем php-xml

```
sudo apt-get install php-xml
```

---

Устанавливаем Symfony:

```
composer create-project symfony/website-skeleton project_1 
```

project_1 - это папка, которая будет создана, в данном каталоге

Эта операция будет выполняться 15-20 минут.

Далее переходите в эту папку с проектом

Установка Doctrine не нужна, но если вы сомневаетесь, то проверьте, установился ли Doctrine, вот этой командой:

```
composer require symfony/orm-pack
```

---

Далее нужно будет в этой корневой директории symphony файл 

```
.env
```

Он скрыт, по умолчанию. Просто введите команду:

```
nano .env
```

в корневой папке проекта, и он откроется.

Нужно заменить всё на нужные значения, для подключения к БД. 

Я выбрал СУБД sqlite - там нужно указать только путь к файлу .db

---

Список задач, которые нужно будет реализовать:

Конечно, вот список функций, которые вам нужно реализовать на основе описания задания:

1. **Добавление пользователя**: Реализуйте функцию, которая позволяет добавлять новых пользователей в систему. Эта функция должна принимать данные пользователя и сохранять их в базе данных.
2. **Получение списка задач пользователя**: Реализуйте функцию, которая возвращает список задач для определенного пользователя. Если пользователя не существует, функция должна возвращать код ошибки 4XX.
3. **Добавление задачи пользователя**: Реализуйте функцию, которая позволяет добавлять новые задачи для определенного пользователя. Эта функция должна принимать данные задачи и сохранять их в базе данных.
4. **Удаление задачи пользователя**: Реализуйте функцию, которая позволяет удалять задачи пользователя. Эта функция должна принимать идентификатор задачи и удалять соответствующую задачу из базы данных.
5. **Обновление задачи пользователя**: Реализуйте функцию, которая позволяет обновлять задачи пользователя. Эта функция должна принимать идентификатор задачи и новые данные задачи, а затем обновлять соответствующую задачу в базе данных.

Эти функции должны быть реализованы как методы в вашем Rest API и должны взаимодействовать с вашей базой данных через Doctrine (или аналогичный инструмент). Удачи вам в выполнении этого задания! 😊

---

Структура простой БД:

Создание таблиц:

```SQL
CREATE TABLE Пользователи (
    IDпользователя INTEGER PRIMARY KEY,
    ИмяПользователя TEXT NOT NULL
);

CREATE TABLE Задачи (
    IDзадачи INTEGER PRIMARY KEY,
    ОписаниеЗадачи TEXT NOT NULL
);

CREATE TABLE Назначения (
    IDзадачи INTEGER,
    IDпользователя INTEGER,
    PRIMARY KEY (IDзадачи, IDпользователя),
    FOREIGN KEY (IDзадачи) REFERENCES Задачи (IDзадачи),
    FOREIGN KEY (IDпользователя) REFERENCES Пользователи (IDпользователя)
);
```

Наполнение таблиц:

```sql
INSERT INTO Пользователи (ИмяПользователя) VALUES
('Сергей Смирнов'),
('Иван Сидоров'),
('Пётр Васильев'),
('Анна Сидорова'),
('Мария Попова'),
('Виктор Соколов');

INSERT INTO Задачи (ОписаниеЗадачи) VALUES
('Разработка сценария'),
('Дизайн персонажей'),
('Программирование AI'),
('Программирование движка игры'),
('Тестирование уровней');

INSERT INTO Назначения (IDзадачи, IDпользователя) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 1);
```

Я выполнил эти команды, используя sqlite в моей основной системе, через командную строку. И потом просто перенёс файл .db в Linux

---

Далее, нужно создать контроллер, и всё там прописать:

1. Создаём новый контроллер - это .php файл в директории src/Controller/

Пишем там сам код запроса (ниже)

2. Добавляем этот контроллер в конфиг, он лежит по пути config/routes.yaml

Например:

```
get_users:
    path: /user
    controller: App\Controller\UserController::getUsers
    methods: GET
```



---

Нужно запустить сервер Symphony:

```
php -S 127.0.0.1:8000 -t public/
```

Остановить сервер можно так: Ctrl+C

Тестирование (в Insomnia):

```
GET http://localhost:8000/user
```



---

Контроллер для запроса:

```php
GET http://localhost:8000/user
```

Файл лежит в: src/Controller/UserController.php

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class UserController extends AbstractController
{
    /**
     * @Route("/user", methods={"GET"})
     */
    public function getUsers(Connection $connection): Response
    {
        // Запрос SQL для получения всех строк из таблицы "Пользователи"
        $sql = 'SELECT * FROM Пользователи';
        $stmt = $connection->prepare($sql);
        $result = $stmt->executeQuery();

        // Получаем результаты запроса
        $users = $result->fetchAllAssociative();

        // Возвращаем пользователей в формате JSON
        return $this->json($users);
    }
}
```

---

Запрос лежит в файле "Реализуемые методы для 4 задания"

---

Все реализуемые методы:

```php
Пользователи
Создать (Create): POST http://localhost:8000/user
Читать (Read): GET http://localhost:8000/user/{id}
Читать (Read): GET http://localhost:8000/user
Обновить (Update): PUT http://localhost:8000/user/{id}
Удалить (Delete): DELETE http://localhost:8000/user/{id}

Задачи
Создать (Create): POST http://localhost:8000/task
Читать (Read): GET http://localhost:8000/task/{id}
Читать (Read): GET http://localhost:8000/task
Обновить (Update): PUT http://localhost:8000/task/{id}
Удалить (Delete): DELETE http://localhost:8000/task/{id}

Назначения
Создать (Create): POST http://localhost:8000/assignment
Читать (Read): GET http://localhost:8000/assignment/{id}
Обновить (Update): PUT http://localhost:8000/assignment/{id}
Удалить (Delete): DELETE http://localhost:8000/assignment/{id}

Задачи, назначенные пользователю
GET http://localhost:8000/user/{id}/tasks
```

Запрос, для получения задач, назначенных пользователю:

```sql
SELECT Задачи.IDзадачи, Задачи.ОписаниеЗадачи
FROM Задачи
JOIN Назначения ON Задачи.IDзадачи = Назначения.IDзадачи
WHERE Назначения.IDпользователя = {id};
```

---

Вот на этом шаге я поставил VSCode, для удобного просмотра и редактирования кодовых файлов проекта

Выполните все команды, по порядку:

```bash
sudo apt-get install wget gpg

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code 
```

Так стало работать в разы удобнее

---

## Пользователи:

Полный UserController:

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class UserController extends AbstractController
{
	/**
     * @Route("/user", methods={"POST"})
     */
    public function createUser(Connection $connection, Request $request): Response
    {
        $data = json_decode($request->getContent(), true);

        $sql = 'INSERT INTO Пользователи (IDпользователя, ИмяПользователя) VALUES (?, ?)';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['IDпользователя']);
        $stmt->bindValue(2, $data['ИмяПользователя']);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_CREATED);
    }

    /**
     * @Route("/user/{id}", methods={"PUT"})
     */
    public function updateUser(Connection $connection, Request $request, $id): Response
    {
        $data = json_decode($request->getContent(), true);

        $sql = 'UPDATE Пользователи SET ИмяПользователя = ? WHERE IDпользователя = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['ИмяПользователя']);
        $stmt->bindValue(2, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }

    /**
     * @Route("/user/{id}", methods={"GET"})
     */
    public function getUser(Connection $connection, $id): Response
    {
        $sql = 'SELECT * FROM Пользователи WHERE IDпользователя = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $result = $stmt->executeQuery();

        $user = $result->fetchAssociative();

        return $this->json($user);
    }

    /**
     * @Route("/user", methods={"GET"})
     */
    public function getUsers(Connection $connection): Response
    {
        $sql = 'SELECT * FROM Пользователи';
        $stmt = $connection->prepare($sql);
        $result = $stmt->executeQuery();

        $users = $result->fetchAllAssociative();

        return $this->json($users);
    }

    /**
     * @Route("/user/{id}", methods={"DELETE"})
     */
    public function deleteUser(Connection $connection, $id): Response
    {
        $sql = 'DELETE FROM Пользователи WHERE IDпользователя = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }
    
    
    /**
 * @Route("/user/{id}/tasks", methods={"GET"})
 */
public function fetchUserTasks(Connection $connection, $id): Response
{
    $sql = 'SELECT Задачи.IDзадачи, Задачи.ОписаниеЗадачи FROM Задачи JOIN Назначения ON Задачи.IDзадачи = Назначения.IDзадачи WHERE Назначения.IDпользователя = ?';
    $stmt = $connection->prepare($sql);
    $stmt->bindValue(1, $id);
    $result = $stmt->executeQuery();

    $tasks = $result->fetchAllAssociative();

    return $this->json($tasks);
}
}

```

Запросы:

Работают:

```
Получить всех пользователей:

Метод: GET
URL: http://localhost:8000/user

Получить конкретного пользователя:

Метод: GET
URL: http://localhost:8000/user/{id}

Создать пользователя:

Метод: POST
URL: http://localhost:8000/user
Тело запроса (метод From URL): ИмяПользователя : <имя>

Удалить пользователя:

Метод: DELETE
URL: http://localhost:8000/user/{id}

Обновить пользователя:

Метод: PUT
URL: http://localhost:8000/user/{id}
Тело запроса(метод From URL): ИмяПользователя : <новое имя>
```

Нужно не забыть добавить все эти запросы в конфиг:

```
config/routes.yaml

create_user:
    path: /user
    controller: App\Controller\UserController::createUser
    methods: POST

get_user:
    path: /user/{id}
    controller: App\Controller\UserController::getUser
    methods: GET

get_users:
    path: /user
    controller: App\Controller\UserController::getUsers
    methods: GET

update_user:
    path: /user/{id}
    controller: App\Controller\UserController::updateUser
    methods: PUT

delete_user:
    path: /user/{id}
    controller: App\Controller\UserController::deleteUser
    methods: DELETE
    
    
    
get_user_tasks:
    path: /user/{id}/tasks
    controller: App\Controller\UserController::fetchUserTasks
    methods: GET

```

----

## Задачи:

Файл TaskController.php

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\DBAL\Connection;

class TaskController extends AbstractController
{

    /**
     * @Route("/task", methods={"POST"})
     */
    public function createTask(Connection $connection, Request $request): Response
    {
        $data = $request->request->all();

        $sql = 'INSERT INTO Задачи (ОписаниеЗадачи) VALUES (?)';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['ОписаниеЗадачи']);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_CREATED);
    }

    /**
     * @Route("/task/{id}", methods={"PUT"})
     */
    public function updateTask(Connection $connection, Request $request, $id): Response
    {
        $data = $request->request->all();

        $sql = 'UPDATE Задачи SET (ОписаниеЗадачи) = (?) WHERE (IDзадачи) = (?)';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['ОписаниеЗадачи']);
        $stmt->bindValue(2, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }

    /**
     * @Route("/task/{id}", methods={"GET"})
     */
    public function fetchTask(Connection $connection, $id): Response
    {
        $sql = 'SELECT * FROM Задачи WHERE IDзадачи = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $result = $stmt->executeQuery();

        $task = $result->fetchAssociative();

        return $this->json($task);
    }

    /**
     * @Route("/task", methods={"GET"})
     */
    public function getTasks(Connection $connection): Response
    {
        $sql = 'SELECT * FROM Задачи';
        $stmt = $connection->prepare($sql);
        $result = $stmt->executeQuery();

        $tasks = $result->fetchAllAssociative();

        return $this->json($tasks);
    }

    /**
     * @Route("/task/{id}", methods={"DELETE"})
     */
    public function deleteTask(Connection $connection, $id): Response
    {
        $sql = 'DELETE FROM Задачи WHERE IDзадачи = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }
}
```

Конфиг:

```
create_task:
    path: /task
    controller: App\Controller\TaskController::createTask
    methods: POST

get_task:
    path: /task/{id}
    controller: App\Controller\TaskController::fetchTask
    methods: GET

get_tasks:
    path: /task
    controller: App\Controller\TaskController::getTasks
    methods: GET

update_task:
    path: /task/{id}
    controller: App\Controller\TaskController::updateTask
    methods: PUT

delete_task:
    path: /task/{id}
    controller: App\Controller\TaskController::deleteTask
    methods: DELETE
```

Запросы:

Работают:

```
Получить все задачи:

Метод: GET 
URL: http://localhost:8000/task

Получить конкретную задачу:

Метод: GET 
URL: http://localhost:8000/task/{id}

Создать задачу:

Метод: POST 
URL: http://localhost:8000/task 
Тело запроса (метод From URL): ОписаниеЗадачи : <описание>

Удалить задачу:

Метод: DELETE 
URL: http://localhost:8000/task/{id}

Обновить задачу:

Метод: PUT 
URL: http://localhost:8000/task/{id} 
Тело запроса (метод From URL): ОписаниеЗадачи : <новое описание>
```

Нужно добавить вот этот кусок кода:

```
    App\Controller\TaskController:
        tags: ['controller.service_arguments']
```

В файл config/services.yaml

После чего перезагрузить php-сервер (Сочетание клавиш `Ctrl + C`, и вызываете последнюю выполненную команду - это будет запуск сервера)

---

## Назначения:

Файл AssController.php

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\DBAL\Connection;

class AssController extends AbstractController
{

    /**
     * @Route("/assignment", methods={"POST"})
     */
    public function createAssignment(Connection $connection, Request $request): Response
    {
        $data = $request->request->all();

        $sql = 'INSERT INTO Назначения (IDзадачи, IDпользователя) VALUES (?, ?)';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['IDзадачи']);
        $stmt->bindValue(2, $data['IDпользователя']);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_CREATED);
    }

    /**
     * @Route("/assignment/{id}", methods={"GET"})
     */
    public function fetchAssignment(Connection $connection, $id): Response
    {
        $sql = 'SELECT * FROM Назначения WHERE IDзадачи = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $result = $stmt->executeQuery();

        $assignment = $result->fetchAssociative();

        return $this->json($assignment);
    }

    /**
     * @Route("/assignment/{id}", methods={"PUT"})
     */
    public function updateAssignment(Connection $connection, Request $request, $id): Response
    {
        $data = $request->request->all();

        $sql = 'UPDATE Назначения SET IDпользователя = ? WHERE IDзадачи = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $data['IDпользователя']);
        $stmt->bindValue(2, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }

    /**
     * @Route("/assignment/{id}", methods={"DELETE"})
     */
    public function deleteAssignment(Connection $connection, $id): Response
    {
        $sql = 'DELETE FROM Назначения WHERE IDзадачи = ?';
        $stmt = $connection->prepare($sql);
        $stmt->bindValue(1, $id);
        $stmt->executeQuery();

        return new Response('', Response::HTTP_NO_CONTENT);
    }
}
```

Конфиг:

```
create_assignment:
    path: /assignment
    controller: App\Controller\AssController::createAssignment
    methods: POST

get_assignment:
    path: /assignment/{id}
    controller: App\Controller\AssController::fetchAssignment
    methods: GET

update_assignment:
    path: /assignment/{id}
    controller: App\Controller\AssController::updateAssignment
    methods: PUT

delete_assignment:
    path: /assignment/{id}
    controller: App\Controller\AssController::deleteAssignment
    methods: DELETE
```

Запросы:

Работают:

```
Получить конкретное назначение:

Метод: GET 
URL: http://localhost:8000/assignment/1

Создать назначение:

Метод: POST 
URL: http://localhost:8000/assignment 
Тело запроса (метод From URL): IDзадачи : <id задачи>, IDпользователя : <id пользователя>

Удалить назначение:

Метод: DELETE 
URL: http://localhost:8000/assignment/{id}
```

---

```
Получить задачи, назначенные пользователю:

Метод: GET 
URL: http://localhost:8000/user/{id}/tasks
```



























































