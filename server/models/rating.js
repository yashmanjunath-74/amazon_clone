const mongoose = require('mongoose');

const ratingShema = new mongoose.Schema({
    userId:{
        type: String,
        required: true,
    },
    rating:{
        type: Number,
        required : true
    }
});

module.exports= ratingShema;