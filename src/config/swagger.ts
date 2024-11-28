import swaggerJSDoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";
import dotenv from "dotenv";

import { Application } from "express";

dotenv.config();

const PORT = process.env.PORT || 3222;
const DB_HOST = process.env.DB_HOST || "localhost";

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Документация для бэка",
      version: "1.0.0",
      description:
        "Доки для API диплома. Тема: Веб-приложения для контроля финансов\nСделал: Гусев А. М 3094",
    },
    components: {
      schemas: {
        User: {
          type: "object",
          properties: {
            id: { type: "integer" },
            firstName: { type: "string" },
            lastName: { type: "string" },
            email: { type: "string" },
            password: { type: "string" },
            dateOfBirth: { type: "string", format: "date" },
            accountType: { type: "integer" },
          },
        },

        CreateUser: {
          type: "object",
          required: [
            "firstName",
            "lastName",
            "email",
            "password",
            "dateOfBirth",
            "accountType",
          ],
          properties: {
            firstName: { type: "string", description: "Имя пользователя" },
            lastName: { type: "string", description: "Фамилия пользователя" },
            email: {
              type: "string",
              description: "Электронная почта пользователя",
            },
            password: { type: "string", description: "Пароль пользователя" },
            dateOfBirth: {
              type: "string",
              format: "date",
              description: "Дата рождения пользователя",
            },
            accountType: {
              type: "integer",
              description: "Тип аккаунта пользователя",
            },
          },
        },
        UpdateUser: {
          type: "object",
          properties: {
            firstName: {
              type: "string",
              description: "Обновлённое имя пользователя",
            },
            lastName: {
              type: "string",
              description: "Обновлённая фамилия пользователя",
            },
            email: {
              type: "string",
              description: "Обновлённая электронная почта пользователя",
            },
            password: {
              type: "string",
              description: "Обновлённый пароль пользователя",
            },
            dateOfBirth: {
              type: "string",
              format: "date",
              description: "Обновлённая дата рождения пользователя",
            },
            accountType: {
              type: "integer",
              description: "Обновлённый тип аккаунта пользователя",
            },
          },
        },

        Note: {
          type: "object",
          properties: {
            id: { type: "integer", description: "Идентификатор заметки" },
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            title: { type: "string", description: "Заголовок заметки" },
            description: {
              type: "string",
              description: "Описание заметки (опционально)",
            },
            creationDate: {
              type: "string",
              format: "date-time",
              description: "Дата создания заметки",
            },
            reminderDate: {
              type: "string",
              format: "date-time",
              description: "Дата напоминания (опционально)",
            },
          },
        },
        CreateNote: {
          type: "object",
          required: ["userId", "title"],
          properties: {
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            title: { type: "string", description: "Заголовок заметки" },
            description: {
              type: "string",
              description: "Описание заметки (опционально)",
            },
            reminderDate: {
              type: "string",
              format: "date-time",
              description: "Дата напоминания (опционально)",
            },
          },
        },
        UpdateNote: {
          type: "object",
          properties: {
            title: {
              type: "string",
              description: "Обновлённый заголовок заметки",
            },
            description: {
              type: "string",
              description: "Обновлённое описание заметки (опционально)",
            },
            reminderDate: {
              type: "string",
              format: "date-time",
              description: "Обновлённая дата напоминания (опционально)",
            },
          },
        },

        Transaction: {
          type: "object",
          properties: {
            id: { type: "integer", description: "Идентификатор транзакции" },
            accountId: {
              type: "integer",
              description: "Идентификатор аккаунта",
            },
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            categoryId: {
              type: "integer",
              description: "Идентификатор категории",
            },
            isIncome: {
              type: "boolean",
              description: "Признак доходной транзакции",
            },
            amount: {
              type: "number",
              format: "float",
              description: "Сумма транзакции",
            },
            transactionDate: {
              type: "string",
              format: "date-time",
              description: "Дата транзакции",
            },
          },
        },
        CreateTransaction: {
          type: "object",
          required: ["accountId", "userId", "categoryId", "isIncome", "amount"],
          properties: {
            accountId: {
              type: "integer",
              description: "Идентификатор аккаунта",
            },
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            categoryId: {
              type: "integer",
              description: "Идентификатор категории",
            },
            isIncome: {
              type: "boolean",
              description: "Признак доходной транзакции",
            },
            amount: {
              type: "number",
              format: "float",
              description: "Сумма транзакции",
            },
          },
        },
        UpdateTransaction: {
          type: "object",
          properties: {
            accountId: {
              type: "integer",
              description: "Идентификатор аккаунта",
            },
            categoryId: {
              type: "integer",
              description: "Идентификатор категории",
            },
            isIncome: {
              type: "boolean",
              description: "Признак доходной транзакции",
            },
            amount: {
              type: "number",
              format: "float",
              description: "Сумма транзакции",
            },
          },
        },

        Account: {
          type: "object",
          properties: {
            id: { type: "integer" },
            ownerId: { type: "integer" },
            accountName: { type: "string" },
            totalBalance: { type: "number", format: "float" },
            currency: { type: "string" },
          },
        },

        Category: {
          type: "object",
          properties: {
            id: { type: "integer", description: "Идентификатор категории" },
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            categoryName: { type: "string", description: "Название категории" },
            image: {
              type: "string",
              format: "uri",
              description: "URL изображения категории",
            },
          },
        },
        CreateCategory: {
          type: "object",
          required: ["userId", "categoryName"],
          properties: {
            userId: {
              type: "integer",
              description: "Идентификатор пользователя",
            },
            categoryName: { type: "string", description: "Название категории" },
            image: {
              type: "string",
              format: "uri",
              description: "URL изображения категории (опционально)",
            },
          },
        },
        UpdateCategory: {
          type: "object",
          properties: {
            categoryName: {
              type: "string",
              description: "Обновлённое название категории",
            },
            image: {
              type: "string",
              format: "uri",
              description: "Обновлённое URL изображения категории",
            },
          },
        },
      },
    },
    servers: [
      {
        url: `http://localhost:${PORT}`,
      },
    ],
  },
  apis: ["./src/routers/*.ts"],
};

const swaggerSpec = swaggerJSDoc(options);

export const swaggerDocs = (app: Application, port: number | string) => {
  // Указываем типы
  app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
  console.log(`Swagger docs available at http://localhost:${port}/api-docs`);
};
