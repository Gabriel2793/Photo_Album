import React, { useState } from 'react';
import axios from 'axios';
import { Input } from '../Input';
import Modal from '../shared/header/Modal/Modal';
import $ from 'jquery';
import { useUsers } from './UserProvider';


export default function Signin() {

    const [ clientPassword ] = Input('');
    const [ clientEmail ] = Input('');
    const [ signInClient, setSignInClient ] = useState( { title:'', text:'', id:'Modal2' } );
    const { getPosts } = useUsers();

    const signin = ( event ) => {
        event.preventDefault();
        axios.post( 'http://localhost:3000/api/signin', { email: clientEmail.value, password: clientPassword.value })
        .then( response => {
            if( response.data.state === 'Success' ) {
                localStorage.setItem( 'users', JSON.stringify( response.data ) );
                getPosts( response.data.id, response );
            }else{
                setSignInClient( { title:'Error', text:'Bad Email or Password', id:'Modal2' } );
                $( '#'+signInClient.id ).modal( 'toggle' );
            }
        })
        .catch( error => {
            setSignInClient( { title:'Error', text:'Server does not respond', id:'Modalg' } );
            $( signInClient.id ).modal( 'toggle' );
        });
    }
    return (
        <>
            <div className="col-12">
                <form className="col-4 offset-4" onSubmit={ signin } >
                    <div className="form-group">
                        <label htmlFor="exampleInputEmail1">Email address</label>
                        <input { ...clientEmail } type="email" className="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" />
                        <small id="emailHelp" className="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div className="form-group">
                        <label htmlFor="exampleInputPassword1">Password</label>
                        <input { ...clientPassword } type="password" className="form-control" id="exampleInputPassword1" />
                    </div>
                    <button type="submit" className="btn btn-primary">Submit</button>
                </form>
            </div>
            <Modal { ...signInClient } />
        </>
    );
}