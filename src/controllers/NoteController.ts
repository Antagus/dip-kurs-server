import { Request, Response } from "express";
import { NoteService } from "../services/NoteService";
import { getErrorMessage } from "../utils";

export class NoteController {
  static async createNote(req: Request, res: Response): Promise<void> {
    try {
      const { title, description, reminderDate, userId } = req.body;

      const newNote = await NoteService.createNote({
        title,
        description,
        reminderDate,
        userId,
      });

      res.status(201).json(newNote);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async getNoteById(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const note = await NoteService.getNoteById(id);
      res.json(note);
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async updateNote(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const { title, description, reminderDate, userId } = req.body;
      const updatedNote = await NoteService.updateNote(id, title, description);
      res.json(updatedNote);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async deleteNote(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      await NoteService.deleteNote(id);
      res.status(204).send();
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async getUserNotes(req: Request, res: Response): Promise<void> {
    try {
      const userId = Number(req.params.userId);
      const notes = await NoteService.getUserNotes(userId);
      res.json(notes);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }
}
