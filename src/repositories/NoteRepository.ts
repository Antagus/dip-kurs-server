import pool from "../config/db";
import { Note } from "../models";

export class NoteRepository {
  static async createNote(note: Omit<Note, "id">): Promise<Note> {
    const { title, description, reminderDate, userId } = note;

    const result = await pool.query(
      "SELECT * FROM create_note($1, $2, $3, $4)",
      [userId, title, description, reminderDate]
    );

    return result.rows[0];
  }

  static async getNoteById(id: number): Promise<Note | null> {
    const result = await pool.query("SELECT * FROM get_note_by_id($1)", [id]);
    return result.rows[0] || null;
  }

  static async updateNote(
    id: number,
    title: string,
    description: string
  ): Promise<Note | null> {
    const result = await pool.query("SELECT * FROM update_note($1, $2, $3)", [
      id,
      title,
      description,
    ]);
    return result.rows[0] || null;
  }

  static async deleteNote(id: number): Promise<void> {
    await pool.query("SELECT delete_note($1)", [id]);
  }

  static async getUserNotes(userId: number): Promise<Note[]> {
    const result = await pool.query("SELECT * FROM get_user_notes($1)", [
      userId,
    ]);
    return result.rows;
  }
}
