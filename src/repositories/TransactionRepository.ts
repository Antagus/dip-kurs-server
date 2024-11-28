import pool from "../config/db";
import { Transaction } from "../models";

export class TransactionRepository {
  // Создать транзакцию
  static async createTransaction(
    transaction: Omit<Transaction, "id">
  ): Promise<Transaction> {
    const { accountId, userId, categoryId, isIncome, amount } = transaction;

    const result = await pool.query(
      "SELECT * FROM create_transaction($1, $2, $3, $4, $5)",
      [accountId, userId, categoryId, isIncome, amount]
    );
    return result.rows[0];
  }

  // Получить транзакцию по ID
  static async getTransactionById(id: number): Promise<Transaction | null> {
    const result = await pool.query("SELECT * FROM get_transaction_by_id($1)", [
      id,
    ]);
    return result.rows[0] || null;
  }

  // Обновить транзакцию
  static async updateTransaction(
    id: number,
    accountId: number,
    categoryId: number,
    isIncome: boolean,
    amount: number
  ): Promise<Transaction | null> {
    const result = await pool.query(
      "SELECT * FROM update_transaction($1, $2, $3, $4, $5)",
      [id, accountId, categoryId, isIncome, amount]
    );
    return result.rows[0] || null;
  }

  // Удалить транзакцию
  static async deleteTransaction(id: number): Promise<void> {
    await pool.query("SELECT delete_transaction($1)", [id]);
  }

  // Получить транзакции аккаунта
  static async getAccountTransactions(
    accountId: number
  ): Promise<Transaction[]> {
    const result = await pool.query(
      "SELECT * FROM get_account_transactions($1)",
      [accountId]
    );
    return result.rows;
  }

  // Получить транзакции по категории
  static async getTransactionsByCategory(
    categoryId: number
  ): Promise<Transaction[]> {
    const result = await pool.query(
      "SELECT * FROM get_transactions_by_category($1)",
      [categoryId]
    );
    return result.rows;
  }
}
