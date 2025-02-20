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

   productRouter.get('/api/product/search/:name',Auth, async (req,res)=>{
      try{
       console.log(req.query.category);
       const product = await Product.find({ 
       name: { $regex : req.params.name , $options:"i" }
       });
       console.log(product);
       res.json(product);
       
      }catch(e){
         res.status(500).json({error:e.message});
      }
          
     });



module.exports= productRouter;