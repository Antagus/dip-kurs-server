import { Router } from "express";
import { NoteController } from "../controllers/NoteController";

const router = Router();

/**
 * @swagger
 * /notes:
 *   post:
 *     summary: Создание новой заметки
 *     description: Создаёт новую заметку для указанного пользователя.
 *     tags: [Заметки]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateNote'
 *     responses:
 *       201:
 *         description: Note created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Note'
 *       400:
 *         description: Bad request.
 */
router.post("/", (req, res) => NoteController.createNote(req, res));

/**
 * @swagger
 * /notes/{id}:
 *   get:
 *     summary: Получение заметки по ID
 *     description: Возвращает информацию о заметке по указанному ID.
 *     tags: [Заметки]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор заметки
 *     responses:
 *       200:
 *         description: Note found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Note'
 *       404:
 *         description: Note not found.
 *       500:
 *         description: Internal server error.
 */
router.get("/:id", (req, res) => NoteController.getNoteById(req, res));

/**
 * @swagger
 * /notes/{id}:
 *   put:
 *     summary: Обновление заметки
 *     description: Обновляет информацию о заметке по указанному ID.
 *     tags: [Заметки]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор заметки
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UpdateNote'
 *     responses:
 *       200:
 *         description: Note updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Note'
 *       400:
 *         description: Bad request.
 *       404:
 *         description: Note not found.
 */
router.put("/:id", (req, res) => NoteController.updateNote(req, res));

/**
 * @swagger
 * /notes/{id}:
 *   delete:
 *     summary: Удаление заметки
 *     description: Удаляет заметку по указанному ID.
 *     tags: [Заметки]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор заметки
 *     responses:
 *       204:
 *         description: Note deleted successfully.
 *       404:
 *         description: Note not found.
 *       500:
 *         description: Internal server error.
 */
router.delete("/:id", (req, res) => NoteController.deleteNote(req, res));

/**
 * @swagger
 * /notes/user/{userId}:
 *   get:
 *     summary: Получение заметок пользователя
 *     description: Возвращает список всех заметок, принадлежащих указанному пользователю.
 *     tags: [Заметки]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: Идентификатор пользователя
 *     responses:
 *       200:
 *         description: List of user notes retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Note'
 *       404:
 *         description: User or notes not found.
 */
router.get("/user/:userId", (req, res) =>
  NoteController.getUserNotes(req, res)
);

export default router;
