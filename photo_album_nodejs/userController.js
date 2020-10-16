const bcrypt = require( 'bcrypt' );
const { response } = require('express');
const jwt = require( 'jsonwebtoken' );

function registerUser( req, res ) {
    const { knex } = req.app.locals;

    if(req.body.app == 'undefined'){
        data = { ...req.body, file:req.file.buffer };
    }else{
        data = req.body;
        delete data.app;
        data.file = Buffer(data.file, 'base64');
    }

    const requiredFields = [ 'username', 'password', 'email', 'file' ];
    const requiredKeys = Object.keys( data );
    const requiredFieldsExist = requiredFields.every( field => requiredKeys.includes( field ) );
    const saltRound = 10;
    
    if( requiredFieldsExist ) {
        bcrypt.genSalt( saltRound, ( error, salt ) => {
            bcrypt.hash( data.password, salt, ( error, hash ) => {
                knex( 'users' )
                .insert( { ...data, password: hash } )
                .then( response => res.status( 200 ).json( { title: 'Success', text:'Client created' } ) )
                .catch( error => res.status( 400 ).json( { title: 'Error', text:error.sqlMessage } ) );
            } );
        } );
    }else{
        res.status( 400 ).json( { text:`The following fields are required: ${ requiredFields }` } );
    }
};

function createPost( req, res ) {
    const { knex } = req.app.locals;
    data = null;

    if(req.body.app == 'undefined'){
        data = { ...req.body, file:req.file.buffer };
    }else{
        data = req.body;
        delete data.app;
        data.file = Buffer(data.file, 'base64');
    }
    console.log(data)
    const requiredFields = [ 'title', 'idea', 'file', 'type_file', 'user_id' ];
    const requiredKeys = Object.keys( data );
    const requiredFieldsExist = requiredFields.every( field => requiredKeys.includes( field ) );
    console.log(requiredFieldsExist)
    if( requiredFieldsExist ) {
        knex( 'user_posts' )
        .insert( data )
        .then( response => res.status( 200 ).json( { title: 'Success', text:'Post created' } ) )
        .catch( error => {
            console.log( error.sqlMessage );
            res.status( 400 ).json( { title: 'Error', text:error.sqlMessage } )
        } );
    }else{
        res.status( 400 ).json( { text:`The following fields are required: ${ requiredFields }` } );
    }
};

function signIn( req, res ) {
    const { knex } = req.app.locals;
    const data = req.body;

    knex( 'users' )
    .where('email', data.email)
    .then( response => {
        bcrypt.compare( data.password, response[0].password, ( error, result ) => {
            if( result && ( response.length > 0 ) ) {
                const payload = {
                    username: response[0].username,
                    isAdmin: true
                };
                const secret = 's3cr3t';
                const expiresIn = 60000;
                const token = jwt.sign( payload, secret, { expiresIn });
                res.status( 200 ).json( { state:'Success', token, logIn: true, id: response[0].id, file: response[0].file.toString('base64') } );
            }else{
                res.status( 200 ).json( { state:'Error'} );
            }
        } );
    } )
    .catch( error => {
        res.status(500).json( {state:'error', message:'Bad User or password.'} );
    } );
}

function getPosts( req, res ) {
    const { knex } = req.app.locals;
    const data = req.params;
    knex( 'user_posts' )
    .where('user_id', data.id)
    .then( response => {
        elements = response.map( element => {
            element.file = element.file.toString('base64');
            return element;
        });
        res.status( 200 ).json( elements );
    } );
}

module.exports = {
    registerUser,
    signIn,
    getPosts,
    createPost
}