import { Router } from "express";
import { CategoryController } from "../controllers/CategoryController";

const router = Router();

/**
 * @swagger
 * /categories:
 *   post:
 *     summary: Создание новой категории
 *     description: Создаёт новую категорию для пользователя.
 *     tags: [Категории]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateCategory'
 *     responses:
 *       201:
 *         description: Category created successfully.
 *       400:
 *         description: Bad request.
 */
router.post("/", (req, res) => CategoryController.createCategory(req, res));

/**
 * @swagger
 * /categories/{id}:
 *   get:
 *     summary: Получение категории по ID
 *     description: Возвращает информацию о категории по указанному ID.
 *     tags: [Категории]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор категории
 *     responses:
 *       200:
 *         description: Category found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Category'
 *       404:
 *         description: Category not found.
 *       500:
 *         description: Internal server error.
 */
router.get("/:id", (req, res) => CategoryController.getCategoryById(req, res));

/**
 * @swagger
 * /categories/{id}:
 *   put:
 *     summary: Обновление категории
 *     description: Обновляет информацию о категории по указанному ID.
 *     tags: [Категории]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор категории
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateCategory'
 *     responses:
 *       200:
 *         description: Category updated successfully.
 *       400:
 *         description: Bad request.
 *       404:
 *         description: Category not found.
 */
router.put("/:id", (req, res) => CategoryController.updateCategory(req, res));

/**
 * @swagger
 * /categories/{id}:
 *   delete:
 *     summary: Удаление категории
 *     description: Удаляет категорию по указанному ID.
 *     tags: [Категории]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор категории
 *     responses:
 *       204:
 *         description: Category deleted successfully.
 *       404:
 *         description: Category not found.
 *       500:
 *         description: Internal server error.
 */
router.delete("/:id", (req, res) =>
  CategoryController.deleteCategory(req, res)
);

/**
 * @swagger
 * /categories/user/{userId}:
 *   get:
 *     summary: Получение категорий пользователя
 *     description: Возвращает список всех категорий, принадлежащих указанному пользователю.
 *     tags: [Категории]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     responses:
 *       200:
 *         description: List of user categories retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Category'
 *       404:
 *         description: User or categories not found.
 */
router.get("/user/:userId", (req, res) =>
  CategoryController.getUserCategories(req, res)
);

export default router;
