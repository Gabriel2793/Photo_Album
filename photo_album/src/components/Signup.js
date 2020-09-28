import React, { useState } from 'react';
import { Input } from './Input';
import axios from 'axios';
import { InputImage } from './InputImage';
import $ from 'jquery';
import Modal from './shared/header/Modal/Modal';

export default function Signup() {
    const [ clientName, setClientName ] = Input('');
    const [ clientEmail, setClientEmail ] = Input('');
    const [ clientPassword, setClientPassword ] = Input('');
    const [ clientImage, setClientImage ] = InputImage({ 
        target: {
            files:{},
            name:''
        }
    });

    const [ Message, setMessage ] = useState( { title:'', text:'', id:'myModal' } );

    const createClient = ( event ) => {
        event.preventDefault();
        console.log( clientName.value, clientEmail.value, clientPassword.value, clientImage );
        let dataSend = new FormData()
        dataSend.append('file', clientImage.value.target.files)
        dataSend.append('username', clientName.value)
        dataSend.append('password', clientPassword.value)
        dataSend.append('email', clientEmail.value)
        axios.post( 
            'http://localhost:3000/api/registeruser',
            dataSend
        ).then( response => {
            setClientEmail('');
            setClientPassword('');
            setClientName('');
            setClientImage();
            setMessage( { ...response.data, id: 'myModal'} );
            $( '#'+Message.id ).modal( 'toggle' );
        })
        .catch( error => {
            console.log( error );
        });
    }

    return (
        <>
            <div className="col-12">
                <form className="col-4 offset-4" onSubmit={ createClient }>
                    <div className="form-group">
                        <label htmlFor="exampleInputName1">Name</label>
                        <input { ...clientName } type="text" className="form-control" id="exampleInputName1" aria-describedby="nameHelp" />
                    </div>
                    <div className="form-group">
                        <label htmlFor="exampleInputEmail1">Email address</label>
                        <input { ...clientEmail } type="email" className="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" />
                        <small id="emailHelp" className="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div className="form-group">
                        <label htmlFor="exampleInputPassword1">Password</label>
                        <input { ...clientPassword } type="password" className="form-control" id="exampleInputPassword1" />
                    </div>
                    <div className="form-group">
                        <div className="custom-file">
                            <input value='' onChange = { clientImage.onChange } type="file"  className="custom-file-input" id="customFileLangHTML" />
                            <label className="custom-file-label" htmlFor="customFileLangHTML" data-browse="Image">{ clientImage.value.target.name }</label>
                        </div>
                    </div>
                    <button type="submit" className="btn btn-primary m-2">Submit</button>
                </form>
            </div>
            <Modal { ...Message } />
        </>
    );
}