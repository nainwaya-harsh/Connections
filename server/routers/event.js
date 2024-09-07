const express=require('express')
const Event=require('../models/event')
const eventRouter=express.Router();
const {user, User}=require("../models/user");
const auth=require("../middlewares/auth")


eventRouter.post("/api/event",async (req,res)=>{
    try {
        const {ename,edate,etime,ecity,eaddress,enumber,eguests}=req.body;

        const exisitingEvent=await Event.findOne({ename});
        if(exisitingEvent){
           return res.status(400).json({msg:"Event Already Exist"})
        }

        let event=new Event({
            ename,
            edate,
            etime,
            ecity, 
            eaddress, 
            enumber,
            eguests 
        })
        event=await event.save();
        res.json(event)
    } catch (error) {
        res.status(500).json({error:error.message})
    }
})

eventRouter.get("/api/getEvents",async(req,res)=>{
    try {
        const event=await Event.find({})
    res.json(event);
    } catch (error) {
        res.status(500).json({error:error.message})
    }
    
})

eventRouter.post("/api/addUserToEvent",auth,async(req,res)=>{
    try {
        const {event_id,user_id}=req.body;
        const event=await Event.findById(event_id);
        const user=await User.findById(user_id);
        event.eguests.push({ user_id });
        await event.save();
          res.json(event);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

eventRouter.post("/api/removeUserFromEvent",auth,async(req,res)=>{
    try {
        const{event_id,user_id}=req.body;
        const event=await Event.findById(event_id);
        const user=await User.findById(user_id);
        event.eguests.pull({user_id});
        await event.save();
        res.json(event);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

eventRouter.post("/api/event/eventallguest",auth,async(req,res)=>{
    try {
        const {eventguest}=req.body;
        console.log(eventguest);
        const users=await User.find({'_id':{$in:eventguest}});
        res.json(users);


    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

eventRouter.post("/api/event/eventList",auth,async(req,res)=>{
    try {
        const {eventIds}=req.body;
        const event=await Event.find({'_id':{$in:eventIds}});
        res.json(event);


    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

 
module.exports=eventRouter; 