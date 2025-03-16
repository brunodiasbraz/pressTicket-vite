const fs = require("fs");
const path = require("path");

// Diretório base que você quer rodar. Pode alterar para 'pages' ou qualquer outro.
const baseDir = path.join(__dirname, "src/pages");

function renameJsToJsx(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });

  entries.forEach((entry) => {
    const entryPath = path.join(dir, entry.name);

    if (entry.isDirectory()) {
      // Recursivo para percorrer subpastas
      renameJsToJsx(entryPath);
    } else if (entry.isFile() && path.extname(entry.name) === ".js") {
      const fileName = path.basename(entry.name, ".js"); // Mantém o nome do arquivo
      const newFileName = `${fileName}.jsx`; // Só troca a extensão
      const newFilePath = path.join(dir, newFileName);

      fs.renameSync(entryPath, newFilePath);
      console.log(`✅ Renomeado: ${entryPath} -> ${newFilePath}`);
    }
  });
}

renameJsToJsx(baseDir);

console.log("🚀 Renomeação concluída!");

