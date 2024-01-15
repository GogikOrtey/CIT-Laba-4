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