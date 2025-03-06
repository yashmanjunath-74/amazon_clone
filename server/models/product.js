const mongoose = require('mongoose');
const ratingSchema = require('./rating');

const productSchema = new mongoose.Schema({
    productName: {
        type: String,
        require: true,
        trim: true,
    },
    price: {
        type: Number,
        require: true,
    },
    quantity: {
        type: Number,
        require: true,
    },
    description: {
        type: String,
        require: true,
        trim: true,
    },
    category: {
        type: String,
        require: true,
        trim: true,
    },
    images: [
        {
            type: String,
            require: true,
        },
    ],
    rating: [ratingSchema],
});

const Product = mongoose.model('Product',productSchema );
module.exports= { Product, productSchema};