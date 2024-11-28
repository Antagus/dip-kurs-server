import { Request, Response } from "express";
import { TransactionService } from "../services/TransactionService";
import { getErrorMessage } from "../utils";

export class TransactionController {
  // Создать транзакцию
  static async createTransaction(req: Request, res: Response): Promise<void> {
    try {
      const newTransaction = await TransactionService.createTransaction(
        req.body
      );
      res.status(201).json(newTransaction);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  // Получить транзакцию по ID
  static async getTransactionById(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const transaction = await TransactionService.getTransactionById(id);
      res.json(transaction);
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  // Обновить транзакцию
  static async updateTransaction(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      const { accountId, categoryId, isIncome, amount } = req.body;
      const updatedTransaction = await TransactionService.updateTransaction(
        id,
        accountId,
        categoryId,
        isIncome,
        amount
      );
      res.json(updatedTransaction);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  // Удалить транзакцию
  static async deleteTransaction(req: Request, res: Response): Promise<void> {
    try {
      const id = Number(req.params.id);
      await TransactionService.deleteTransaction(id);
      res.status(204).send();
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  // Получить транзакции аккаунта
  static async getAccountTransactions(
    req: Request,
    res: Response
  ): Promise<void> {
    try {
      const accountId = Number(req.params.accountId);
      const transactions =
        await TransactionService.getAccountTransactions(accountId);
      res.json(transactions);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  // Получить транзакции по категории
  static async getTransactionsByCategory(
    req: Request,
    res: Response
  ): Promise<void> {
    try {
      const categoryId = Number(req.params.categoryId);
      const transactions =
        await TransactionService.getTransactionsByCategory(categoryId);
      res.json(transactions);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }
}
