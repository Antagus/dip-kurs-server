import { TransactionRepository } from "../repositories/TransactionRepository";
import { Transaction } from "../models";
import { ValidationError } from "../utils/";

export class TransactionService {
  // Создать транзакцию
  static async createTransaction(
    transaction: Omit<Transaction, "id">
  ): Promise<Transaction> {
    const { accountId, userId, categoryId, isIncome, amount, name } = transaction;

    if (!accountId || !userId) {
      throw new ValidationError(
        "All fields are required: accountId, userId, categoryId, isIncome, amount."
      );
    }

    return await TransactionRepository.createTransaction(transaction);
  }

  // Получить транзакцию по ID
  static async getTransactionById(id: number): Promise<Transaction | null> {
    if (!id) {
      throw new ValidationError("Transaction ID is required.");
    }

    const transaction = await TransactionRepository.getTransactionById(id);
    if (!transaction) {
      throw new ValidationError("Transaction not found.");
    }

    return transaction;
  }

  // Обновить транзакцию
  static async updateTransaction(
    id: number,
    accountId: number,
    categoryId: number,
    isIncome: boolean,
    amount: number
  ): Promise<Transaction | null> {
    if (!id || !accountId || !categoryId || amount === undefined) {
      throw new ValidationError(
        "All fields are required: id, accountId, categoryId, isIncome, amount."
      );
    }

    const transaction = await TransactionRepository.getTransactionById(id);
    if (!transaction) {
      throw new ValidationError("Transaction not found.");
    }

    return await TransactionRepository.updateTransaction(
      id,
      accountId,
      categoryId,
      isIncome,
      amount
    );
  }

  // Удалить транзакцию
  static async deleteTransaction(id: number): Promise<void> {
    if (!id) {
      throw new ValidationError("Transaction ID is required.");
    }

    const transaction = await TransactionRepository.getTransactionById(id);
    if (!transaction) {
      throw new ValidationError("Transaction not found.");
    }

    await TransactionRepository.deleteTransaction(id);
  }

  // Получить транзакции аккаунта
  static async getAccountTransactions(
    accountId: number
  ): Promise<Transaction[]> {
    if (!accountId) {
      throw new ValidationError("Account ID is required.");
    }

    return await TransactionRepository.getAccountTransactions(accountId);
  }

  // Получить транзакции по категории
  static async getTransactionsByCategory(
    categoryId: number
  ): Promise<Transaction[]> {
    if (!categoryId) {
      throw new ValidationError("Category ID is required.");
    }

    return await TransactionRepository.getTransactionsByCategory(categoryId);
  }
}
