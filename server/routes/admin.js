const express = require('express');
const adminRouter =express.Router();
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const { prependListener } = require('../models/user');
const Order = require('../models/order');



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

adminRouter.get('/admin/get-orders',admin, async(req,res)=>{
    try{ 
       const orders = await Order.find({});
       res.json(orders);  
    }catch(e){
       res.status(500).json({error:e.message});
    }
   });


   adminRouter.post('/admin/change-order-status',admin, async(req,res)=>{
      try{ 
         const {id ,Status} = req.body;
         let order = await Order.findById(id);
         order.status = Status;
         order =  await order.save();
         res.json(order);  
      }catch(e){
         res.status(500).json({error:e.message});
      }
     });

   adminRouter.get('/admin/analytics',admin, async(req,res)=>{
      try{
         const orders = await Order.find({});
          let totalEarnings  = 0;

          for(let i =0 ; i< orders.length; i++){
            for(let j =0; j< orders[i].products.length; j++){
               totalEarnings += orders[i].products[j].product.price * orders[i].products[j].quantity;
            }
          }
      //Category wise earnings
      let MobilesEarnings = await getEarnings('Mobiles');
      let EssentialsEarnings = await getEarnings('Essentials');
      let AppliancesEarnings = await getEarnings('Appliances');
      let BookEarnings = await getEarnings('Books');
      let FashionEarnings = await getEarnings('Fashion');

      let earnings= {
         totalEarnings,
         MobilesEarnings,
         EssentialsEarnings,
         AppliancesEarnings,
         BookEarnings,
         FashionEarnings
      };

      res.json(earnings);
     
      }catch(e){
         res.status(500).json({error:e.message});
      }
   });

   async function getEarnings(category){
      const orders = await Order.find({ 'products.product.category': category});
      let totalEarnings = 0;
      for(let i =0 ; i< orders.length; i++){
         for(let j =0; j< orders[i].products.length; j++){
            totalEarnings += orders[i].products[j].product.price * orders[i].products[j].quantity;
         }
      }
      return totalEarnings;
   }
module.exports = adminRouter;