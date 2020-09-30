import React from 'react';
import { Redirect } from 'react-router-dom';
import { useUsers } from './context/UserProvider';

export default function ProtectedComponent( { component } ) {
    const Component = component;
    const {  users } = useUsers();

    return users.logIn ?
            (
                <>
                    <Component />
                </>
            )
            :
            (
                <>
                    <Redirect to={ { pathname: '/' } } />
                </>
            );
}