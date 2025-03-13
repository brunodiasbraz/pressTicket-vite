import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(() => {
  return {
    plugins: [react()],
    base: "/",
    build: {
      outDir: "build", // O Vite por padrão gera o build na pasta "dist"
    },
  };
});