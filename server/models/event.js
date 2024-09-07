const mongoose=require('mongoose')
const {userSchema}=require('../models/user')
const eventSchema=mongoose.Schema({
    ename:{
        required:true,
        type:String
    },
    edate:{
        required:true,
        type:String
    },
    etime:{
        required:true,
        type:String
    },
    ecity:{
        required:true,
        type:String
    },
    eaddress:{
        required:true,
        type:String
    },
    enumber:{
        required:true,
        type:String
    },
    eguests:[]
})

const Event=mongoose.model("Event",eventSchema)
module.exports=Event;