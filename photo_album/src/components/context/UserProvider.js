import React, { useState, createContext, useContext, useEffect } from 'react';
import axios from 'axios';
import {  useHistory } from 'react-router-dom';

const UserContext = createContext();
export const useUsers = () => useContext( UserContext );
const usersData = JSON.parse( localStorage.getItem( 'users' ) ) || { logIn: false };
const userPostsData = JSON.parse( localStorage.getItem( 'userPosts' ) ) || [];

export function UserProvider( { children } ) {
    const [ users, setUsers ] = useState( usersData );
    const [ userPosts, setUserPosts ] = useState( userPostsData );
    const history =  useHistory();

    useEffect( () => {
        localStorage.setItem( 'userPosts', JSON.stringify( userPosts ) );
    }, [ userPosts ] );

    const getUsers = () => {
        axios.get(`http://localhost:3000/api/theposts`)
            .then(res => {
             console.log(res);
            });
    };

    const changeUserData = ( data ) => {
        setUsers( data );
    }

    const addPost = ( posts ) => {
        setUserPosts( posts );
    }

    const getPosts = ( user_id, response ) => {

        axios.get( `http://localhost:3000/api/getposts/${ user_id }` )
            .then( res => {
                // const modifiedImages = res.data.map( dataImage => { 
                //     console.log(dataImage.file)
                //     return { ...dataImage, file:btoa(dataImage.file.data.reduce((data, byte) => data + String.fromCharCode(byte), '')) }
                // } );
                var modifiedImages = res.data;
                localStorage.setItem( 'userPosts', JSON.stringify( modifiedImages ) );
                changeUserData( response.data );
                setUserPosts( modifiedImages );
                return history.push( '/myinstagram' );
            } );
    }

    return (
            <UserContext.Provider value={ { users, getUsers, changeUserData, userPosts, addPost, getPosts } }>
                { children }
            </UserContext.Provider>
    );
}