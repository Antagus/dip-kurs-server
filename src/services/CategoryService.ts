import { CategoryRepository } from "../repositories/CategoryRepository";
import { Category } from "../models";
import { ValidationError } from "../utils/";

export class CategoryService {
  // Создание новой категории
  static async createCategory(
    category: Omit<Category, "id">
  ): Promise<Category> {
    const { image, categoryName, userId } = category;

    if (!userId || !categoryName) {
      throw new ValidationError("User ID and category name are required.");
    }

    return await CategoryRepository.createCategory(category);
  }

  // Получить категорию по ID
  static async getCategoryById(id: number): Promise<Category | null> {
    if (!id) {
      throw new ValidationError("Category ID is required.");
    }

    const category = await CategoryRepository.getCategoryById(id);
    if (!category) {
      throw new ValidationError("Category not found.");
    }

    return category;
  }

  // Обновление категории
  static async updateCategory(
    id: number,
    categoryName: string,
    image: string,
    categoryType: string,
    color: string
  ): Promise<Category | null> {
    if (!id || !categoryName) {
      throw new ValidationError("Category ID and name are required.");
    }

    const category = await CategoryRepository.getCategoryById(id);
    if (!category) {
      throw new ValidationError("Category not found.");
    }

    return await CategoryRepository.updateCategory(
      id,
      categoryName,
      image,
      categoryType,
      color
    );
  }

  // Удаление категории
  static async deleteCategory(id: number): Promise<void> {
    if (!id) {
      throw new ValidationError("Category ID is required.");
      return;
    }

    await CategoryRepository.deleteCategory(id);
  }

  // Получение всех категорий пользователя
  static async getUserCategories(userId: number): Promise<Category[]> {
    if (!userId) {
      throw new ValidationError("User ID is required.");
    }

    return await CategoryRepository.getUserCategories(userId);
  }
}
