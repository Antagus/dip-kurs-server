const path = require("path");
const nodeExternals = require("webpack-node-externals");

module.exports = {
  entry: "./src/server.ts", // Точка входа в приложение
  target: "node", // Указываем, что проект предназначен для Node.js
  externals: [nodeExternals()], // Исключаем `node_modules` из сборки
  mode: "development", // Режим разработки
  module: {
    rules: [
      {
        test: /\.ts$/, // Обрабатываем файлы TypeScript
        use: "ts-loader",
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [".ts", ".js"], // Поддержка TypeScript и JavaScript файлов
  },
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
};
