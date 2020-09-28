import React from 'react';
import { useUsers } from '../../context/UserProvider';
import { Link } from 'react-router-dom';

export default function Header() {
    const { users, changeUserData } = useUsers();
    let whenLogOffShow = <></>;

    const signOut = () => {
        changeUserData( {signIn:false} );
    }

    if ( users.logIn === true ) {
        whenLogOffShow =  <li className="nav-item">
                            <Link className="nav-link" onClick={ signOut }> Sign out </Link>
                          </li>;
    }else{
        whenLogOffShow = (
            <>
                <li className="nav-item">
                    <Link className="nav-link" to="/"> Home </Link> <span className="sr-only">(current)</span>
                </li>
                <li className="nav-item">
                    <Link className="nav-link" to="/settings"> Settings </Link>
                </li>
                <li className="nav-item">
                    <Link className="nav-link" to="/signup"> Sign Up </Link>
                </li>
                <li className="nav-item">
                    <Link className="nav-link" to="/signin"> Sign In </Link>
                </li>
            </>
        );
    }

    return (
        <>
            <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
                <Link className="navbar-brand" to="/myinstagram">Photo Album</Link>
                <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>

                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav mr-auto">
                        { whenLogOffShow }
                    </ul>
                </div>
            </nav>
        </>
    )
}