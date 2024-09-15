const mongoose=require('mongoose');

const userSchema=mongoose.Schema({

    fname:{
        required:true,
        type: String
    },
    lname:{
        required:true,
        type: String
    },
    email:{
        required:true,
        type: String
    },
    password:{
        required:true,
        type: String
    },
    mobilenumber:{
        required:true,
        type: String
    },
    profile:{
        type: String
    },
    description:{
        type: String
    },
    linkedin:{
        type: String
    },
    whatsapp:{
        type: String
    },
    contact:{
        type: String
    },
    following:[],
    followers:[],
    eventcreated:[],
    eventattended:[],
    notification:[],

})

const User=mongoose.model("User",userSchema)
module.exports={User,userSchema};