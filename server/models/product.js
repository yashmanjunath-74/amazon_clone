const mongoose = require('mongoose');
const ratingShema = require('./rating');

const productShema = new mongoose.Schema({
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
    rating: [ratingShema],
});

const Product = mongoose.model('Product',productShema );
module.exports= Product;