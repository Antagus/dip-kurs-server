import { Router } from "express";
import { TransactionController } from "../controllers/TransactionController";

const router = Router();

/**
 * @swagger
 * /transactions:
 *   post:
 *     summary: Создание новой транзакции
 *     description: Создаёт новую транзакцию с указанными данными.
 *     tags: [Транзакции]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateTransaction'
 *     responses:
 *       201:
 *         description: Transaction created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Transaction'
 *       400:
 *         description: Bad request.
 */
router.post("/", (req, res) =>
  TransactionController.createTransaction(req, res)
);

/**
 * @swagger
 * /transactions/{id}:
 *   get:
 *     summary: Получение транзакции по ID
 *     description: Возвращает информацию о транзакции по указанному ID.
 *     tags: [Транзакции]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор транзакции
 *     responses:
 *       200:
 *         description: Transaction found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Transaction'
 *       404:
 *         description: Transaction not found.
 *       500:
 *         description: Internal server error.
 */
router.get("/:id", (req, res) =>
  TransactionController.getTransactionById(req, res)
);

/**
 * @swagger
 * /transactions/{id}:
 *   put:
 *     summary: Обновление транзакции
 *     description: Обновляет информацию о транзакции по указанному ID.
 *     tags: [Транзакции]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор транзакции
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateTransaction'
 *     responses:
 *       200:
 *         description: Transaction updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Transaction'
 *       400:
 *         description: Bad request.
 *       404:
 *         description: Transaction not found.
 */
router.put("/:id", (req, res) =>
  TransactionController.updateTransaction(req, res)
);

/**
 * @swagger
 * /transactions/{id}:
 *   delete:
 *     summary: Удаление транзакции
 *     description: Удаляет транзакцию по указанному ID.
 *     tags: [Транзакции]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор транзакции
 *     responses:
 *       204:
 *         description: Transaction deleted successfully.
 *       404:
 *         description: Transaction not found.
 *       500:
 *         description: Internal server error.
 */
router.delete("/:id", (req, res) =>
  TransactionController.deleteTransaction(req, res)
);

/**
 * @swagger
 * /transactions/account/{accountId}:
 *   get:
 *     summary: Получение транзакций аккаунта
 *     description: Возвращает список всех транзакций, связанных с указанным аккаунтом.
 *     tags: [Транзакции]
 *     parameters:
 *       - in: path
 *         name: accountId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор аккаунта
 *     responses:
 *       200:
 *         description: List of account transactions retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Transaction'
 *       404:
 *         description: Account not found or no transactions available.
 */
router.get("/account/:accountId", (req, res) =>
  TransactionController.getAccountTransactions(req, res)
);

/**
 * @swagger
 * /transactions/category/{categoryId}:
 *   get:
 *     summary: Получение транзакций по категории
 *     description: Возвращает список всех транзакций, связанных с указанной категорией.
 *     tags: [Транзакции]
 *     parameters:
 *       - in: path
 *         name: categoryId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор категории
 *     responses:
 *       200:
 *         description: List of transactions by category retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Transaction'
 *       404:
 *         description: Category not found or no transactions available.
 */
router.get("/category/:categoryId", (req, res) =>
  TransactionController.getTransactionsByCategory(req, res)
);

export default router;
