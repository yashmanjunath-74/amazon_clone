const express = require('express');
const userRouter =express.Router();
const Auth = require('../middlewares/auth');

userRouter.post('/api/add-to-cart', Auth , async ( req,res) => {
    try{
        const {id}= req.body;
        const product = await Product.findById(id);

        let user = await User.findById(req.user._id);


        if(user.cart.length === 0){
            user.cart.push({product: product._id, quantity: 1});
        }else{
            let index = user.cart.findIndex((obj) => obj.product == id);
            if(index === -1){
                user.cart.push({product: product._id, quantity: 1});
            }else{
                user.cart[index].quantity += 1;
            }
        }
    }catch(e){
        res.status(500).json({error: e.message });
    }

    });

module.exports = userRouter;