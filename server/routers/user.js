const express=require('express')
const {user,User}=require('../models/user')
const userRouter=express.Router();
const auth=require("../middlewares/auth")
const event=require('../models/event');
const Event = require('../models/event');
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

userRouter.post("/api/user/eventCreated",auth,async(req,res)=>{
    try { 
        const{event_id,user_id}=req.body;
        const user=await User.findById(user_id);
        user.eventcreated.push({event_id});
        await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

userRouter.post("/api/adduserevent",auth,async(req,res)=>{
    try {
        const{user_id,event_id}=req.body;
        const user=await User.findById(user_id)
        const event=await Event.findById(event_id);
        // user.eventname.push(event);
        user.eventattended.push({event_id});
        await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
}) 
userRouter.post("/api/removeuserevent",auth,async(req,res)=>{
    try {
        const{user_id,event_id}=req.body;
        const user=await User.findById(user_id)
        const event=await Event.findById(event_id);
        user.eventattended.pull({event_id});
        await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
}) 

userRouter.post("/api/getFollowingDetails", auth, async (req, res) => {
    try {
        const { followingIds } = req.body;
        const users = await User.find({ '_id': { $in: followingIds } });
        res.json(users);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.post("/api/getFollowersDetails", auth, async (req, res) => {
    try {
        const { followersIds } = req.body;
        console.log(followersIds);
        const users = await User.find({ '_id': { $in: followersIds } });
        res.json(users);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.post("/api/sendNotification",auth,async(req,res)=>{
    try {
        const{notification,guest_id}=req.body;
        const user=await User.findById(guest_id);
        user.notification.push({notification});
        user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})
userRouter.post("/api/clearNotification",auth,async(req,res)=>{
    try {
        const{user_id}=req.body;
        const user=await User.findById(user_id);
        user.notification=[];
        user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

userRouter.post("/api/user/editdetails",auth,async(req,res)=>{
    try {
        const{fname,lname,email,mobilenumber,description,linkedin,whatsapp,contact,user_id}=req.body;
        const user=await User.findById(user_id);
        user.fname=fname;
        user.lname=lname;
        user.email=email;
        user.mobilenumber=mobilenumber;
        user.description=description;
        user.linkedin=linkedin;
        user.whatsapp=whatsapp;
        user.contact=contact;
        await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message})
    }
})


userRouter.post("/api/user/profilephotoupdated",auth,async(req,res)=>{
    try {
        const{profile,user_id}=req.body;
        const user=await User.findById(user_id);
        user.profile=profile;
        await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error:error.message})
    }
})





module.exports=userRouter;