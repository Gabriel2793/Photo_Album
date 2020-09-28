import React from 'react';
import { useUsers } from './context/UserProvider';

export default function Body() {
    const { getUsers } = useUsers();
    return (
        <>
            <button type="button" className="btn btn-primary" onClick={ () => getUsers() }>Primary</button>
        </>
    );
}