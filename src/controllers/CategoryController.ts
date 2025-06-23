import { Request, Response } from "express";
import { CategoryService } from "../services/CategoryService";
import { getErrorMessage } from "../utils";

export class CategoryController {
  static async createCategory(req: Request, res: Response): Promise<void> {
    try {
      const newCategory = await CategoryService.createCategory(req.body);
      res.status(201).json(newCategory);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async getCategoryById(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const category = await CategoryService.getCategoryById(id);
      res.json(category);
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async updateCategory(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const { categoryName, image, categoryType, color } = req.body;
      const updatedCategory = await CategoryService.updateCategory(
        id,
        categoryName,
        image,
        categoryType,
        color
      );
      res.json(updatedCategory);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async deleteCategory(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      await CategoryService.deleteCategory(id);
      res.status(204).send();
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async getUserCategories(req: Request, res: Response): Promise<void> {
    try {
      const userId = Number(req.params.userId);
      const categories = await CategoryService.getUserCategories(userId);
      res.json(categories);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }
}
