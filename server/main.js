const express = require("express");
const app = express();
const PORT = 3000;

app.use(express.json()); // Aby móc odbierać dane w formacie JSON

// Przechowujemy produkty w pamięci
let products = [
  { id: 1, name: "Produkt 1", price: 10 },
  { id: 2, name: "Produkt 2", price: 20 },
  { id: 3, name: "Produkt 3", price: 30 },
];

// 1) Endpoint auth/ zwraca token i refresh token
app.get("/auth", (req, res) => {
  res.json({ token: "secret", refresh: "refresh_token" });
});

// 2) Endpoint products/ zwraca listę produktów
app.get("/products", (req, res) => {
  res.json(products);
});

// 3) Endpoint addProducts/ dodaje nowy produkt do listy produktów
app.post("/addProducts", (req, res) => {
  const newProduct = req.body; // Zakładamy, że nowy produkt jest w body żądania
  if (!newProduct || !newProduct.name || !newProduct.price) {
    return res
      .status(400)
      .json({ message: "Proszę podać poprawne dane produktu (name, price)." });
  }

  // Ustalanie nowego ID produktu (max ID + 1)
  const newId =
    products.length > 0 ? Math.max(...products.map((p) => p.id)) + 1 : 1;
  const productToAdd = { id: newId, ...newProduct };

  products.push(productToAdd);
  res.status(201).json(productToAdd);
});

app.listen(PORT, () => {
  console.log(`Serwer działa na porcie ${PORT}`);
});
