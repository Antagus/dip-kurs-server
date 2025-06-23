import { AccountRepository } from "../repositories/AccountRepository";
import { Account } from "../models";
import { ValidationError } from "../utils/";

export class AccountService {
  static async createAccount(account: Omit<Account, "id">): Promise<Account> {
    const { ownerId, accountName, totalBalance, currency } = account;

    // Простая валидация входных данных
    if (!ownerId || !accountName || !currency) {
      throw new ValidationError(
        "Owner ID, account name, and currency are required."
      );
    }

    const allowedCurrencies = ["USD", "EUR", "RUB", "BTC", "ETH"];
    if (!allowedCurrencies.includes(currency)) {
      throw new ValidationError(
        `Currency must be one of the following: ${allowedCurrencies.join(", ")}`
      );
    }

    return await AccountRepository.createAccount(account);
  }

  static async getAccountById(id: number): Promise<Account | null> {
    if (!id) {
      throw new ValidationError("Account ID is required.");
    }

    const account = await AccountRepository.getAccountById(id);
    if (!account) {
      throw new ValidationError("Account not found.");
    }

    return account;
  }

  static async updateAccount(
    id: number,
    accountName: string,
    totalBalance: number,
    currency: string
  ): Promise<Account | null> {
    if (!id) {
      throw new ValidationError("Account ID is required.");
    }

    const account = await AccountRepository.getAccountById(id);
    if (!account) {
      throw new ValidationError("Account not found.");
    }

    if (!accountName || !currency) {
      throw new ValidationError("Account name and currency are required.");
    }

    return await AccountRepository.updateAccount(
      id,
      accountName,
      totalBalance,
      currency
    );
  }

  // Удаление аккаунта
  static async deleteAccount(id: number): Promise<void> {
    if (!id) {
      throw new ValidationError("Account ID is required.");
    }

    const account = await AccountRepository.getAccountById(id);
    if (!account) {
      throw new ValidationError("Account not found.");
    }

    await AccountRepository.deleteAccount(id);
  }

  // Получение всех аккаунтов пользователя
  static async getUserAccounts(userId: number): Promise<Account[]> {
    if (!userId) {
      throw new ValidationError("User ID is required.");
    }

    return await AccountRepository.getUserAccounts(userId);
  }

  // Получение баланса аккаунта
  static async getAccountBalance(accountId: number): Promise<number> {
    if (!accountId) {
      throw new ValidationError("Account ID is required.");
    }

    return await AccountRepository.getAccountBalance(accountId);
  }
}
