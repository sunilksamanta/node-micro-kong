require('dotenv').config();
const express = require('express');
const {connectMongo} = require("./database");
const app = express();

const init = async() => {
    if(!process.env.SERVICE_ID) {
        console.error('SERVICE_ID is required');
        process.exit(1);
    }
    console.log = console.log.bind(console, `[${process.env.SERVICE_ID}]`);
    await connectMongo();

    app.use(require('./api'));
    app.get('/health', (req, res) => {
        res.json({status: 'ok', service: process.env.SERVICE_ID});
    } );

    app.listen(process.env.PORT, () => {
        console.log(`Listening on port ${process.env.PORT}`);
    } );
}

init().then(r => console.log(`${process.env.SERVICE_ID} service started`)).catch(e => console.error(`Error starting ${process.env.SERVICE_ID} service: ${e.message}`));
