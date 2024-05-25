const express=require('express')
const {user,User}=require('../models/user')
const userRouter=express.Router();
const auth=require("../middlewares/auth")

userRouter.post("/api/addFollowers",auth,async(req,res)=>{
    try {
        const{user_id,guest_id}=req.body;
        const user=await User.findById(user_id);
        const guest=await User.findById(guest_id);
        user.following.push({guest_id});
        guest.followers.push({user_id});
        await user.save();
        await guest.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

module.exports=userRouter;