import pool from "../config/db";
import { User } from "../models";

export class UserRepository {
  static async getAll(): Promise<User[]> {
    const result = await pool.query(`SELECT * FROM "User"`);
    return result.rows;
  }

  static async create(user: Omit<User, "id">): Promise<User> {
    const {
      firstName,
      lastName,
      middleName,
      email,
      password,
      dateOfBirth,
      accountType,
    } = user;
    const result = await pool.query(
      "SELECT * FROM create_user($1, $2, $3, $4, $5, $6, $7)",
      [
        firstName,
        lastName,
        middleName,
        email,
        password,
        dateOfBirth,
        accountType,
      ]
    );
    return result.rows[0];
  }

  static async getById(id: number): Promise<User | null> {
    const result = await pool.query("SELECT * FROM get_user_info($1)", [id]);
    return result.rows[0] || null;
  }

  static async update(id: number, user: Partial<User>): Promise<User | null> {
    const { firstName, lastName, middleName, email, password, accountType } =
      user;
    const result = await pool.query(
      "SELECT * FROM update_user($1, $2, $3, $4, $5, $6, $7)",
      [id, firstName, lastName, middleName, email, password, accountType]
    );
    return result.rows[0] || null;
  }

  static async delete(id: number): Promise<void> {
    await pool.query("SELECT delete_user($1)", [id]);
  }

  static async authenticate(
    email: string,
    password: string
  ): Promise<User | null> {
    const result = await pool.query("SELECT * FROM authenticate_user($1, $2)", [
      email,
      password,
    ]);
    return result.rows[0] || null;
  }

  static async findByEmail(email: string): Promise<User | null> {
    const result = await pool.query("SELECT * FROM find_user_by_email($1)", [
      email,
    ]);
    return result.rows[0] || null;
  }

  static async findByAccountType(accountType: number): Promise<User[]> {
    const result = await pool.query(
      "SELECT * FROM find_users_by_account_type($1)",
      [accountType]
    );
    return result.rows;
  }

  static async registerUser(
    user: Omit<User, "id" | "registrationDate">
  ): Promise<User> {
    const {
      firstName,
      lastName,
      middleName,
      email,
      password,
      dateOfBirth,
      accountType,
    } = user;
    const result = await pool.query(
      "SELECT * FROM register_user($1, $2, $3, $4, $5, $6, $7)",
      [
        firstName,
        lastName,
        middleName,
        email,
        password,
        dateOfBirth,
        accountType,
      ]
    );
    return result.rows[0];
  }

  static async changePassword(id: number, newPassword: string): Promise<void> {
    await pool.query("SELECT change_password($1, $2)", [id, newPassword]);
  }

  static async findRecentUsers(limit: number): Promise<User[]> {
    const result = await pool.query("SELECT * FROM find_recent_users($1)", [
      limit,
    ]);
    return result.rows;
  }
}
