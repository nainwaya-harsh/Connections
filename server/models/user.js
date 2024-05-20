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
    following:[],
    followers:[],
    eventname:[]
})

const User=mongoose.model("User",userSchema)
module.exports={User,userSchema};