export const getErrorMessage = (error: unknown): string => {
  if (error instanceof Error) {
    return error.message;
  }
  return "Unknown error occurred";
};

export { ValidationError } from "./validation-error";
