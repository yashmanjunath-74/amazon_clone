const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Auth = require('../middlewares/auth');

const authRouter = express.Router();

authRouter.post('/api/signup',  async (req, res) => {
    //get the data from the client
  try{
    const {name, email, password} = req.body;

    const existinguser =  await User.findOne({ email });
    if(existinguser){
        return res.status(400).json({message: 'User  with same email already exists'});

    }

    const hashpasward = await  bcryptjs.hash(password, 10); 

    let  user = new  User({
        name,
        email,
        password : hashpasward,
    })

    user = await user.save(); 
    res.status(201).json(user);
  }
  catch(e){
    res.status(500).json({ error : e.message});
  }
});

authRouter.post('/api/login', async (req,res)=> {
  try{
    const {email, password } = req.body;
    
    const user = await User.findOne({email});
    if(!user){
      return res.status(400).json({message : "User with this email does not exist!"});
    }
    const isMtch = await bcryptjs.compare(password, user.password);

    if (!isMtch){
      return res.status(400).json({message : "Incorect pasward!"});
    }

    const token =jwt.sign({id: user._id},"passwordKey");
    res.json({token, ...user._doc});

  }catch(e){
     res.status(500).json({error:e.message});
  }
});

//Verify The token 
authRouter.post('/tokenIsValid', async(req,res)=>{
 try{
   const token = req.header("x-auth-token");
   if(!token) return res.json(false);

  const Verify = jwt.verify(token,"passwordKey");
  if(!Verify) return res.json(false);

  const user = await User.findById(Verify.id);
  if(!user) return res.json(false);

  res.json(true);
 }catch(e){
  res.status(500).json({error:e.message});
}
});


// get user Data
authRouter.get('/',Auth ,async(req,res) =>{
  const user = await User.findById(req.user);
  res.json({...user._doc,token:req.token});
});

module.exports = authRouter;