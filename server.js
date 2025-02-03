const express = require('express');
const mongoose = require('mongoose');
const app = express();
const PORT = 3000;
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
app.use(express.json());

const UserSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});

const User = mongoose.model('User', UserSchema); // Create the User model

// Signup Route
app.post('/user/signup', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Validation
        if (!email || !password) {
            return res.status(400).json({ error: 'Email and password are required' });
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: 'Email is already registered' });
        }
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Save the new user to the database
        const newUser = new User({ email, password: hashedPassword });
        await newUser.save();

        res.status(201).json({ message: 'User registered successfully!' });
    } catch (error) {
        res.status(500).json({ error: 'Failed to register user', details: error.message });
    }
});
    
// Login Route
app.post('/user/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Validation
        if (!email || !password) {
            return res.status(400).json({ error: 'Email and password are required' });
        }

        // Check if the user exists
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // Compare the provided password with the hashed password in the database
        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ error: 'Invalid password' });
        }
        // Generate a JSON Web Token (JWT)
        const token = jwt.sign({ id: user._id, email: user.email }, 'your-secret-key', {
            expiresIn: '1h', // Token expires in 1 hour
        });

        res.status(200).json({ message: 'Login successful', token });
    } catch (error) {
        res.status(500).json({ error: 'Failed to login', details: error.message });
    }
});

// Connecting to the MongoDB database using Mongoose
mongoose
.connect('mongodb+srv://admin:Tq89eK}Z@cluster0.rlr8u.mongodb.net/Node-API?retryWrites=true&w=majority&appName=Cluster0', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => {
// Once the database connection is successful, the server starts listening on the specified port
    app.listen(
        PORT,
        () => console.log(`Server is running on http://localhost:${PORT}`)
    )
    console.log('Connected to MongoDB');

}).catch((err) => {
    console.log('Failed to connect to MongoDB', err);
});
