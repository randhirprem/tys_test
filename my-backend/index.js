const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors()); // Allow requests from other origins
app.use(express.json()); // Parse JSON bodies

// MySQL database connection
const db = mysql.createConnection({
  host: 'localhost',        // Replace with your database server's host
  user: 'root',             // Your MySQL username
  password: 'mihir2000',    // Your MySQL password
  database: 'TYSUserDB' // Replace with your database name
});

// Check the database connection
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err.message);
    return;
  }
  console.log('Connected to the database.');
});

// Example API endpoint to fetch data
app.get('/data', (req, res) => {
  db.query('SELECT * FROM Users', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Database query failed' });
      return;
    }
    res.json(results); // Send data as JSON
  });
});

// Example API endpoint to insert data
app.post('/data', (req, res) => {
  const { user_id, username } = req.body; // Example fields
  db.query('INSERT INTO Users (user_id, username) VALUES (?, ?)', [user_id, username], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Database insertion failed' });
      return;
    }
    res.status(201).json({ message: 'Data inserted successfully', id: results.insertId });
  });
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
