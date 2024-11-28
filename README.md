# **dip-kurs-server**

## **Описание**
Этот проект представляет серверную часть приложения с использованием базы данных PostgreSQL.

### **База данных**
- База данных разработана на **PostgreSQL**.
- SQL-дамп базы данных находится в файле: `dump.sql`.

### **Развёртывание базы данных**
Для развёртывания базы данных используйте следующую команду:
```bash
psql -U <username> -h <hostname> -p <port> -d <new_database_name> -f dump.sql
```

### **Основные параметры**
- **Базовый порт сервера:** `3222`
- **Документация API:** доступна по адресу [`/api-docs/`](http://localhost:3222/api-docs/).

---

## **Скриншоты**

### Postman запросы (Коллекцией могу поделиться):
![image](https://github.com/user-attachments/assets/e805caa3-b444-463b-9bb4-3c6cb4ad9350)

### Пример API-документации:
![image](https://github.com/user-attachments/assets/af5765db-3683-48a1-be3a-a4d20a01c64d)
