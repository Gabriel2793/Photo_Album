const jwt = require( 'jsonwebtoken' );

function verifyAthorization( req, res, next ) {
    const { authorization } = req.headers;
    const token = authorization.split(' ')[1];
    jwt.verify( token, 's3cr3t', ( error, decodedToken ) => {
        if( error ) {
            return res.status( 401 ).json( 'Token error' );
        }else{
            req.token = decodedToken;
            next();
        }
    } );
}

module.exports = {
    verifyAthorization
}