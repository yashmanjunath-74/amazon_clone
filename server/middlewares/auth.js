const jwt = require('jsonwebtoken');

const Auth = async (req,res,next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token)
            return res.status(401).json({message:"No auth token , access denied"});

        const Verify = jwt.verify(token,"passwordKey");
        if(!Verify) return res.status(401).json({message: "token Verification failed, access denied"});
    
    req.user= Verify.id; 
    req.token=token;
    next();
    }catch(e){
       res.status(500).json({error: e.message});
    }
}

module.exports = Auth;