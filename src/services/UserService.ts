import { UserRepository } from "../repositories/UserRepository";
import { User } from "../models";

export class UserService {
  static async getAllUsers(): Promise<User[]> {
    return await UserRepository.getAll();
  }

  static async createUser(user: Omit<User, "id">): Promise<User> {
    return await UserRepository.create(user);
  }

  static async getUserById(id: number): Promise<User | null> {
    return await UserRepository.getById(id);
  }

  static async updateUser(
    id: number,
    user: Partial<User>
  ): Promise<User | null> {
    return await UserRepository.update(id, user);
  }

  static async deleteUser(id: number): Promise<void> {
    return await UserRepository.delete(id);
  }

  static async authUser (email: string, password: string): Promise<number | null>  {
    return await UserRepository.authenticate(email, password);
  }
}
