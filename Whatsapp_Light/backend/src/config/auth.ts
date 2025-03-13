export default {
  secret: import.meta.env.JWT_SECRET || "mysecret",
  expiresIn: "15m",
  refreshSecret: import.meta.env.JWT_REFRESH_SECRET || "myanothersecret",
  refreshExpiresIn: "7d"
};
