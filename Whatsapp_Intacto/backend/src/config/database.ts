require("../bootstrap");

module.exports = {
  define: {
    charset: "utf8mb4",
    collate: "utf8mb4_bin"
  },
  dialect: import.meta.env.DB_DIALECT || "mysql",
  timezone: import.meta.env.DB_TIMEZONE || "-03:00",
  host: import.meta.env.DB_HOST || 'localhost',
  database: import.meta.env.DB_NAME || 'press-ticket',
  username: import.meta.env.DB_USER || 'root',
  password: import.meta.env.DB_PASS,
  port: import.meta.env.DB_PORT || 3306,
  logging: false,
  seederStorage: "json",
  seederStoragePath: "sequelizeData.json"
};
