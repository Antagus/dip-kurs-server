import { NoteRepository } from "../repositories/NoteRepository";
import { Note } from "../models";
import { ValidationError } from "../utils/";

export class NoteService {
  static async createNote(note: Omit<Note, "id">): Promise<Note> {
    const { title, description, reminderDate, userId } = note;

    if (!title || !description || !userId) {
      throw new ValidationError("Title, content, and user ID are required.");
    }

    return await NoteRepository.createNote(note);
  }

  static async getNoteById(id: number): Promise<Note | null> {
    if (!id) {
      throw new ValidationError("Note ID is required.");
    }

    const note = await NoteRepository.getNoteById(id);
    if (!note) {
      throw new ValidationError("Note not found.");
    }

    return note;
  }

  static async updateNote(
    id: number,
    title: string,
    description: string
  ): Promise<Note | null> {
    if (!id || !title || !description) {
      throw new ValidationError("Note ID, title, and content are required.");
    }

    const note = await NoteRepository.getNoteById(id);
    if (!note) {
      throw new ValidationError("Note not found.");
    }

    return await NoteRepository.updateNote(id, title, description);
  }

  static async deleteNote(id: number): Promise<void> {
    if (!id) {
      throw new ValidationError("Note ID is required.");
    }

    const note = await NoteRepository.getNoteById(id);
    if (!note) {
      throw new ValidationError("Note not found.");
    }

    await NoteRepository.deleteNote(id);
  }

  static async getUserNotes(userId: number): Promise<Note[]> {
    if (!userId) {
      throw new ValidationError("User ID is required.");
    }

    return await NoteRepository.getUserNotes(userId);
  }
}
