const express = require('express');
const adminRouter =express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/product');
const { prependListener } = require('../models/user');



//add product
adminRouter.post('/admin/add-product', admin, async ( req,res) => {
try{
    const { productName , price, quantity,description,category,images} = req.body;
    let product = new  Product({
        productName , 
        price, 
        quantity,
        description,
        category,
        images
    });

    product = await product.save();
    res.json(product);

}catch(e){
    res.status(500).json({error: e.message });
}
});

adminRouter.get('/admin/get-product',admin, async (req,res)=>{
 try{
  const product = await Product.find({});
  res.json(product);
 }catch(e){
    res.status(500).json({error:e.message});
 }
     
});

adminRouter.post('/admin/delete-product',admin, async(req,res)=>{
 try{ 
    const{ id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
     
 }catch(e){
    res.status(500).json({error:e.message});
 }
});

module.exports = adminRouter;