const express = require('express');
const Auth = require('../middlewares/auth');
const {Product} = require('../models/product');
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
  

  productRouter.post('/api/rate-product', Auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.rating.length; i++) {
            if (String(product.rating[i].userId) === String(req.user)) {
                product.rating.splice(i, 1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating
        };

        product.rating.push(ratingSchema);
        product = await product.save();
        console.log(product);
        res.json(product);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


productRouter.get('/api/deal_of_day', Auth, async (req, res) => {
 
try{
       
    let products = await Product.find({});
    products = products.sort((a, b) => {
        return b.rating.length - a.rating.length;
    });
    console.log(products[0]);
    res.json(products[0]);

}catch(e){
    res.status(500).json({error:e.message});
}
});

module.exports= productRouter;