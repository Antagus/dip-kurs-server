import { Request, Response } from "express";
import { UserService } from "../services/UserService";
import { getErrorMessage } from "../utils";

export class UserController {
  static async getAllUsers(req: Request, res: Response) {
    try {
      const users = await UserService.getAllUsers();
      res.json(users);
    } catch (error) {
      res.status(500).json({ message: getErrorMessage(error) });
    }
  }

  static async createUser(req: Request, res: Response) {
    try {
      const newUser = await UserService.createUser(req.body);
      res.status(201).json(newUser);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async getUserById(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      const user = await UserService.getUserById(id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      res.json(user);
    } catch (error) {
      res.status(500).json({ message: getErrorMessage(error) });
    }
  }

  static async updateUser(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      const updatedUser = await UserService.updateUser(id, req.body);
      res.json(updatedUser);
    } catch (error) {
      res.status(400).json({ message: getErrorMessage(error) });
    }
  }

  static async deleteUser(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      await UserService.deleteUser(id);
      res.status(204).send();
    } catch (error) {
      res.status(500).json({ message: getErrorMessage(error) });
    }
  }

  static async authUser(req: Request, res: Response) {
    try {
      const { email, password } = req.body;
      const idAuthUser = await UserService.authUser(email, password);
      res.status(200).json({ user: idAuthUser });
    } catch (error) {
      res.status(500).json({ message: getErrorMessage(error) });
    }
  }
}
