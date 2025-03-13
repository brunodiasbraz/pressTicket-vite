import dotenv from "dotenv";

dotenv.config({
  path: import.meta.env.NODE_ENV === "test" ? ".env.test" : ".env"
});
