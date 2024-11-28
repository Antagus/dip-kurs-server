import { Request, Response } from "express";
import { AccountService } from "../services/AccountService";
import { getErrorMessage } from "../utils";

export class AccountController {
  static async createAccount(req: Request, res: Response) {
    try {
      const newAccount = await AccountService.createAccount(req.body);
      res.status(201).json(newAccount);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async getAccountById(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      const account = await AccountService.getAccountById(id);
      res.json(account);
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async updateAccount(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      const { accountName, totalBalance, currency } = req.body;
      const updatedAccount = await AccountService.updateAccount(
        id,
        accountName,
        totalBalance,
        currency
      );
      res.json(updatedAccount);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async deleteAccount(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      await AccountService.deleteAccount(id);
      res.status(204).send();
    } catch (error) {
      res.status(404).json({ message: getErrorMessage(error) });
    }
  }

  static async getUserAccounts(req: Request, res: Response) {
    try {
      const userId = Number(req.params.userId);
      const accounts = await AccountService.getUserAccounts(userId);
      res.json(accounts);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async getAccountBalance(req: Request, res: Response) {
    try {
      const accountId = Number(req.params.accountId);
      const balance = await AccountService.getAccountBalance(accountId);
      res.json({ balance });
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }
}
