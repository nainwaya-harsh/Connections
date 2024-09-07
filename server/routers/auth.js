const express=require('express')
const {User}=require("../models/user")
const authRouter=express.Router();
const bycryptjs=require('bcryptjs')
const jwt=require('jsonwebtoken');
const auth=require('../middlewares/auth')
// For creating account
authRouter.post("/api/signup",async(req,res)=>{
    try {
        const{fname,lname,mobilenumber,email,profile,password,eventcreated,eventattended,followers,following,notification}=req.body;
        const existingUser=await User.findOne({email});
        if(existingUser){
            res.status(400).json({msg:"User With Same email Found"})
        }
        const hashedPassword=await bycryptjs.hash(password,8);
        let user=new User({
            fname,
            lname,
            email,
            password:hashedPassword,
            mobilenumber,
            profile,
            eventcreated,
            eventattended,
            followers,
            following,
            notification
        });
        user=await user.save();
        res.json(user)
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

// for login
authRouter.post("/api/signin", async(req,res)=>{
    try {
        const{email,password}=req.body;
        const user=await User.findOne({email})
        if(!user){
           return res.status(400).json({msg:"User Does Not Exist"});
        }
        // const isMatched=user.password==password;
        const isMatched=await bycryptjs.compare(password,user.password);
        if(!isMatched){
           return res.status(400).json({msg:"Password Does Not Matched"})
        }
        const token=jwt.sign({id:user._id},"passwordKey")
        res.json({token,...user._doc});

    } catch (error) {
        res.status(500).json({error:error.message}) 
    }
})

authRouter.post("/tokenIsValid",async(req,res)=>{
    try {
        const token= req.header('x-auth-token');
        if(!token) return res.json(false);
        const verified=jwt.verify(token,"passwordKey")
        if(!verified) return res.json(false)
            const user=await User.findById(verified.id)
        if(!user) return res.json(false)
            res.json(true)
    } catch (error) {
        res.status(500).json({error:error.message})
    }
})

// for getting user data
authRouter.get('/',auth,async(req,res)=>{
    const user=await User.findById(req.user);
    res.json({...user._doc,token:req.token})
})

module.exports=authRouter;