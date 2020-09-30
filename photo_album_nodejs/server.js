const express = require( 'express' );
const app = express();
const router = express.Router();
const { port, database } = require( './settings' );
const routes = require( './routes' );
const middleware = require( './middlewares');
const cors = require('cors');
const multer = require('multer');
const upload=multer()

const knex = require( 'knex' )( {
    client: 'mysql',
    connection: database
} );
app.locals.knex = knex;

app.use(cors({
    "origin":"*",
    "methods":"GET,PATCH,POST,DELETE"
}));
// app.use(function(req, res, next) {
//     res.header("Access-Control-Allow-Origin", "*");
//     res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//     next();
//   });

app.use( express.json() );

router.post( '/registeruser', upload.single('file'), routes.users.registerUser);
router.post( '/signin', routes.users.signIn);
router.post( '/createPost', upload.single('file'), routes.users.createPost);
router.get( '/posts', middleware.verifyAthorization, routes.users.getPosts);
// router.get( '/theposts', routes.users.getPosts);
router.get( '/getposts/:id', routes.users.getPosts);

app.use( '/api', router );

app.listen( port, ()=> {
    console.log( `Server up on port ${ port }`);
});