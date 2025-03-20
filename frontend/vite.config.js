import { defineConfig, transformWithEsbuild } from 'vite';
import react from '@vitejs/plugin-react';
import federation from '@originjs/vite-plugin-federation';

export default defineConfig(() => {
  return {
    plugins: [
      react(),      
      federation({
        name: 'pressTicket',
        filename: 'remoteEntry.js',
        exposes: {
          './Tickets': './src/pages/Tickets/index.jsx',
          './Teste': './src/pages/Teste/index.jsx',
          './App': './src/App.jsx'
        },
         shared: ['react', 'react-dom']
      })
    ],
    build: {
      outDir: "build",
      modulePreload: false,
      target: 'esnext',
      minify: false,
      cssCodeSplit: false
    },
  };
});
