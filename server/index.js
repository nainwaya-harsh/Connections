const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const authRouter = require("./routers/auth")
const eventRouter=require("./routers/event")
const userRouter=require("./routers/user")
const mongoose = require("mongoose")
app.listen(port, "0.0.0.0", () => {
    console.log(`Connected at PORT ${port}`);
});
app.use(express.json());
app.use(authRouter);
app.use(eventRouter); 
app.use(userRouter);
// Connections To Database
const DB = "mongodb://localhost:27017/ConnectionsApp";
mongoose.connect(DB).then(() => { console.log('Connection Succesful to Database'); }).catch((e) => { console.log("Connection Unuccesful to Database"); })

// For Testing Purpose
app.get("/hello", (req, res) => {
    res.status(200).json({ msg: "helllo" })
});
