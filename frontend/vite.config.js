import { defineConfig, transformWithEsbuild } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(() => {
  return {
    plugins: [
      react(),
      {
        name: 'treat-js-files-as-jsx',
        async transform(code, id) {
          // Verifica se o arquivo está em components, layout ou pages e se tem extensão .js
          if (!id.match(/src\/(components|layout|routes|context|pages)\/.*\.js$/)) return null;

          return transformWithEsbuild(code, id, {
            loader: 'jsx',
            jsx: 'automatic',
          });
        },
      },
    ],
    base: "/",
    server: {
      port: 3002,
    },
    build: {
      outDir: "build",
    },
  };
});
