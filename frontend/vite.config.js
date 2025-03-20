import { defineConfig } from 'vite';
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
         shared: ['react', 'react-dom', 'react-router-dom']
      })
    ],
    build: {
      modulePreload: false,
      target: 'esnext',
      minify: false,
      cssCodeSplit: false
    },
    server: {
      cors: {
        origin: function (origin, callback) {
          if ([].includes(origin) || !origin || ['*'].includes('*')) {
            callback(null, true)
          } else {
            callback(new Error(`Not allowed by CORS: ${origin}`))
          }
        },
        methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
        credentials: true,
        allowedHeaders: 'Origin, X-Requested-With, Content-Type, Accept, x-api-key',
      },
    },
    define: {
      'process.env': {}
    }
  };
});
