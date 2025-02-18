//IMPORTING SERVER DEPENDENCIES
const express = require('express');
const mongoose = require('mongoose');


//IMPORTING FROM OTHER FILES
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const Product = require('./models/product');
const productRouter = require('./routes/product');





// INIT
const PORT =  3001;
const app = express();
const DB = "mongodb+srv://yash:yash2005@cluster0.i4siy.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// MIDDELWARESrs
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

app.get('/yash', (req, res) => {    
    res.send('Hello World!');
});

//connect to the database

mongoose.connect(DB)
.then(() => {
    console.log('Connected to the database');
})
.catch((err) => {
    console.log(err);
});     

//LISTENING TO THE SERVER
app.listen(PORT ,"0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
} );