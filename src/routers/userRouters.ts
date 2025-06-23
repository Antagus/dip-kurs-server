import { Router } from "express";
import { UserController } from "../controllers/UserController";
import { asyncHandler } from "../middleware";

const router = Router();

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Получение всех пользователей
 *     description: Возвращает список всех пользователей.
 *     tags: [Пользователи]
 *     responses:
 *       200:
 *         description: List of all users.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/User'
 *       500:
 *         description: Internal server error.
 */
router.get("/", asyncHandler(UserController.getAllUsers));

/**
 * @swagger
 * /users:
 *   post:
 *     summary: Создание нового пользователя
 *     description: Создаёт нового пользователя с указанными данными.
 *     tags: [Пользователи]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateUser'
 *     responses:
 *       201:
 *         description: User created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       400:
 *         description: Bad request.
 */
router.post("/", asyncHandler(UserController.createUser));

/**
 * @swagger
 * /users/{id}:
 *   get:
 *     summary: Получение пользователя по ID
 *     description: Возвращает информацию о пользователе по указанному ID.
 *     tags: [Пользователи]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     responses:
 *       200:
 *         description: User found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       404:
 *         description: User not found.
 *       500:
 *         description: Internal server error.
 */
router.get("/:id", asyncHandler(UserController.getUserById));

/**
 * @swagger
 * /users/{id}:
 *   put:
 *     summary: Обновление данных пользователя
 *     description: Обновляет информацию о пользователе по указанному ID.
 *     tags: [Пользователи]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateUser'
 *     responses:
 *       200:
 *         description: User updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       400:
 *         description: Bad request.
 *       404:
 *         description: User not found.
 */
router.put("/:id", asyncHandler(UserController.updateUser));

/**
 * @swagger
 * /users/{id}:
 *   delete:
 *     summary: Удаление пользователя
 *     description: Удаляет пользователя по указанному ID.
 *     tags: [Пользователи]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     responses:
 *       204:
 *         description: User deleted successfully.
 *       404:
 *         description: User not found.
 *       500:
 *         description: Internal server error.
 */
router.delete("/:id", asyncHandler(UserController.deleteUser));

router.post("/auth/login", asyncHandler(UserController.authUser));

export default router;
