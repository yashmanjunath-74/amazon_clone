const express = require('express');
const Auth = require('../middlewares/auth');
const Product = require('../models/product');
const productRouter =express.Router();

productRouter.get('/api/product',Auth, async (req,res)=>{
    try{
     console.log(req.query.category);
     const product = await Product.find({ category: req.query.category});
     console.log(product);
     res.json(product);
     
    }catch(e){
       res.status(500).json({error:e.message});
    }
        
   });

   productRouter.get('/api/product/search/:productName', Auth, async (req, res) => {
      try {
          console.log(req.params.productName);
          
          const products = await Product.find({
            productName: { $regex: req.params.productName, $options: "i" }
          });
  
          if (!products.length) {
              return res.status(404).json({ message: "No products found" });
          }
  
          console.log(products);
          res.json(products);
  
      } catch (e) {
          res.status(500).json({ error: e.message });
      }
  });
  



module.exports= productRouter;