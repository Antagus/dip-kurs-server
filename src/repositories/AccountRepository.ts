import pool from "../config/db";
import { Account } from "../models";

export class AccountRepository {
  // Создание нового аккаунта
  static async createAccount(account: Omit<Account, "id">): Promise<Account> {
    const { ownerId, accountName, totalBalance, currency } = account;

    const result = await pool.query(
      "SELECT * FROM create_account($1, $2, $3, $4)",
      [ownerId, accountName, totalBalance, currency]
    );
    return result.rows[0];
  }

  // Получение аккаунта по ID
  static async getAccountById(id: number): Promise<Account | null> {
    const result = await pool.query("SELECT * FROM get_account_by_id($1)", [
      id,
    ]);
    return result.rows[0] || null;
  }

  // Обновление аккаунта
  static async updateAccount(
    id: number,
    accountName: string,
    totalBalance: number,
    currency: string
  ): Promise<Account | null> {
    const result = await pool.query(
      "SELECT * FROM update_account($1, $2, $3, $4)",
      [id, accountName, totalBalance, currency]
    );
    return result.rows[0] || null;
  }

  // Удаление аккаунта
  static async deleteAccount(id: number): Promise<void> {
    await pool.query("SELECT delete_account($1)", [id]);
  }

  // Получение всех аккаунтов пользователя
  static async getUserAccounts(userId: number): Promise<Account[]> {
    const result = await pool.query("SELECT * FROM get_user_accounts($1)", [
      userId,
    ]);
    return result.rows;
  }

  // Получение баланса аккаунта
  static async getAccountBalance(accountId: number): Promise<number> {
    const result = await pool.query("SELECT get_account_balance($1)", [
      accountId,
    ]);
    return result.rows[0]?.get_account_balance || 0;
  }
}
