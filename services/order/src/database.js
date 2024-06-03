const mongoose = require('mongoose');
const { MONGO_URI } = process.env;

const connectMongo = async() => {
    try {
        await mongoose.connect(MONGO_URI);
        console.log('Connected to MongoDB');
    } catch (error) {
        console.error('Error connecting to MongoDB:', error);
        throw error;
    }
}
module.exports = { connectMongo };
