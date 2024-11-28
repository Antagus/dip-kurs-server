export interface User {
  id: number;
  firstName: string;
  lastName: string;
  middleName: string | null;
  email: string;
  password: string;
  dateOfBirth: Date;
  registrationDate: Date;
  accountType: number;
}

export interface Account {
  id: number;
  ownerId: number;
  accountName: string;
  totalBalance: number;
  currency: string;
  creationDate: Date;
}

export interface Category {
  id: number;
  image: string | null;
  categoryName: string;
  userId: number;
}

export interface Transaction {
  id: number;
  accountId: number;
  userId: number;
  categoryId: number | null;
  isIncome: boolean;
  amount: number;
  transactionDate: Date;
}

export interface Note {
  id: number;
  userId: number;
  title: string;
  description: string | null;
  creationDate?: Date;
  reminderDate: Date | null;
}
