import { Router } from "express";
import { AccountController } from "../controllers/AccountController";

const router = Router();

/**
 * @swagger
 * /accounts:
 *   post:
 *     summary: Создание нового аккаунта
 *     description: Создаёт новый аккаунт.
 *     tags: [Аккаунты]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Account'
 *     responses:
 *       201:
 *         description: Account created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Account created successfully.
 *       400:
 *         description: Bad request.
 */
router.post("/", (req, res) => AccountController.createAccount(req, res));

/**
 * @swagger
 * /accounts/{id}:
 *   put:
 *     summary: Обновление данных аккаунта
 *     description: Обновляет информацию об аккаунте.
 *     tags: [Аккаунты]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор аккаунта
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateAccount'
 *     responses:
 *       200:
 *         description: Account updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Account updated successfully.
 *       400:
 *         description: Bad request.
 *       404:
 *         description: Account not found.
 */
router.put("/:id", (req, res) => AccountController.updateAccount(req, res));

/**
 * @swagger
 * /accounts/{id}:
 *   delete:
 *     summary: Удаление аккаунта
 *     description: Удаляет аккаунт.
 *     tags: [Аккаунты]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор аккаунта
 *     responses:
 *       204:
 *         description: Account deleted successfully.
 *       404:
 *         description: Account not found.
 */
router.delete("/:id", (req, res) => AccountController.deleteAccount(req, res));

/**
 * @swagger
 * /accounts/user/{userId}:
 *   get:
 *     summary: Получение аккаунтов пользователя
 *     description: Возвращает список всех аккаунтов пользователя.
 *     tags: [Аккаунты]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     responses:
 *       200:
 *         description: List of user accounts retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Account'
 *       404:
 *         description: User or accounts not found.
 */
router.get("/user/:userId", (req, res) =>
  AccountController.getUserAccounts(req, res)
);

/**
 * @swagger
 * /accounts/{accountId}/balance:
 *   get:
 *     summary: Получение баланса аккаунта
 *     description: Возвращает текущий баланс аккаунта.
 *     tags: [Аккаунты]
 *     parameters:
 *       - in: path
 *         name: accountId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор аккаунта
 *     responses:
 *       200:
 *         description: Account balance retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 balance:
 *                   type: number
 *                   format: float
 *                   example: 1000.50
 *       404:
 *         description: Account not found.
 */
router.get("/:accountId/balance", (req, res) =>
  AccountController.getAccountBalance(req, res)
);

export default router;
