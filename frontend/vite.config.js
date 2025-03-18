import { defineConfig, transformWithEsbuild } from 'vite';
import react from '@vitejs/plugin-react';
import federation from '@originjs/vite-plugin-federation';

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
      federation({
        name: 'pressTicket',
        filename: 'remoteEntry.js',
        exposes: {
          './Tickets': './src/pages/Tickets/index.js',
          './Teste': './src/pages/Teste/indes.jsx'
        },
         shared: ['react', 'react-dom', 'react-router-dom']
      })
    ],
    base: "/",
    server: {
      port: 3002,
    },
    build: {
      outDir: "build",
      modulePreload: false,
      target: 'esnext',
      minify: false,
      cssCodeSplit: false
    },
  };
});
