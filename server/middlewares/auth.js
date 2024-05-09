const jwt=require('jsonwebtoken')
const auth=async(req,res,next)=>{
    try {
        const token =req.header('x-auth-token')
        if(!token){
            return res.status(401).json({msg:'no auth token access denied'})
        }
        const verified= jwt.verify(token,"passwordKey")
        if(!verified) return res.status(401).json({msg:'Token verfication failed ,authoruzation denies'})
        req.user=verified.id;
        req.token=token;
        next();
    } catch (error) {
        res.status(400).json({error:error.message})
    }
}

module.exports=auth;
