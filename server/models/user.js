const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({    
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: function(v) {
                return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(v);
            },
            message: props => `${props.value} is not a valid email!`
        }
    },
    password: {
        type: String,
        required: true,
        validate : {
            validator: function(v) {
                return v.length >= 6;
            },
                message: props => `${props.value} enter long password!`
            }
    },
    address :{
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    }
});

const User = mongoose.model('User', userSchema);
module.exports = User;