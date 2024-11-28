export class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ValidationError";
  }

  // Мб дописать логирование в базу данных
}
