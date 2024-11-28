import pool from "../config/db";
import { Category } from "../models";

export class CategoryRepository {
  static async createCategory(
    category: Omit<Category, "id">
  ): Promise<Category> {
    const { image, categoryName, userId } = category;

    const result = await pool.query(
      "SELECT * FROM create_category($1, $2, $3)",
      [image, categoryName, userId]
    );
    return result.rows[0];
  }

  static async getCategoryById(id: number): Promise<Category | null> {
    const result = await pool.query("SELECT * FROM get_category_by_id($1)", [
      id,
    ]);
    return result.rows[0] || null;
  }

  static async updateCategory(
    id: number,
    categoryName: string,
    image: string
  ): Promise<Category | null> {
    const result = await pool.query(
      "SELECT * FROM update_category($1, $2, $3)",
      [id, categoryName, image]
    );
    return result.rows[0] || null;
  }

  static async deleteCategory(id: number): Promise<void> {
    await pool.query("SELECT delete_category($1)", [id]);
  }

  static async getUserCategories(userId: number): Promise<Category[]> {
    const result = await pool.query("SELECT * FROM get_user_categories($1)", [
      userId,
    ]);
    return result.rows;
  }
}
