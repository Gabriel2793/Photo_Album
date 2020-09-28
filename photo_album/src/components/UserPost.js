import React from 'react';

export default function UserPost( { title, idea, id, file, type_file } ) {
    return (
        <div className="col-4">
            <div className="card mt-4" style={ { width: '18rem' } }>
                {/* <img src={ `data:image/png;base64,${ btoa(file.data.reduce((data, byte) => data + String.fromCharCode(byte), '')) }` } className="card-img-top" alt="hola" /> */}
                <img src={ `${type_file},${file}` } className="card-img-top" alt="hola" />
                <div className="card-body">
                    <h5 className="card-title">{ title }</h5>
                    <p className="card-text">{ idea }</p>
                </div>
            </div>
        </div>
    );
}