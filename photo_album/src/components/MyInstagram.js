import React, { useState } from 'react';
import { useUsers } from './context/UserProvider';
import { Input } from './Input';
import { InputImage } from './InputImage';
import axios from 'axios';
import $ from 'jquery';
import Modal from './shared/header/Modal/Modal';
import UserPost from './UserPost';
import bigImage from '../assets/img/paisaje.jpg';
import uuid from 'react-uuid';

export default function MyInstagram() {

    const { userPosts, addPost, users } = useUsers();
    const [ postTitle, setPostTitle ] = Input('');
    const [ postIdea, setPostIdea ] = Input('');
    const [ postImage, setPostImage ] = InputImage({ 
        target: {
            files:{},
            name:''
        }
    });
    const [ Message, setMessage ] = useState( { title:'', text:'', id:'myModal4' } );

    const createPost = ( event ) => {
        event.preventDefault();
        let reader = new FileReader();
        reader.onload = ( e ) => {
            let image = e.target.result.split( ',' );
            let dataSend = new FormData();
            dataSend.append( 'file', postImage.value.target.files );
            dataSend.append( 'title', postTitle.value );
            dataSend.append( 'idea', postIdea.value );
            dataSend.append( 'user_id', users.id );
            dataSend.append( 'type_file', image[0] );

            axios.post( 
                'http://localhost:3000/api/createPost',
                dataSend
            ).then( response => {
                if( response.data.title === "Success" ) {
                    addPost( [ ...userPosts, { id:uuid(), title:postTitle.value, idea:postIdea.value, file:image[1], type_file:image[0] } ] );
                    setPostTitle('');
                    setPostIdea('');
                    setPostImage();
                    setMessage( { ...response.data, id: 'myModal4'} );
                    $( "#Post" ).modal( 'toggle' );
                    $( '#'+Message.id ).modal( 'toggle' );
                }else{
                    setMessage( { title:'Error', text:'Something gots wrong, Try it again.', id:'myModal4' } );
                    $( '#'+Message.id ).modal( 'toggle' );
                }
            })
            .catch( error => {
                console.log( error );
            });
        }
        reader.readAsDataURL( postImage.value.target.files );
    }

    return (
        <>
            <div className="col-12" style={ { height:'24rem', backgroundImage:`url(${ bigImage })`, backgroundSize:'cover' } }>
               <img src={ `data:image/png;base64,${ btoa(users.file.data.reduce((data, byte) => data + String.fromCharCode(byte), '')) }` } className="rounded-circlen" style={ { height:'50%', width:'20%', left:'40%', position: 'absolute', top: '25%',  textAlign: 'center' } } alt="hola" />
            </div>
            <div className="col-12 m-4">
                <button type="button" className="btn btn-primary col-8 offset-2" data-toggle="modal" data-target="#Post">Say what you feel</button>
                <div className="modal" tabIndex="-1" id="Post">
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">Add Post</h5>
                                <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div className="modal-body">
                                <form className="col-8 offset-2" onSubmit={ createPost }>
                                    <div className="form-group">
                                        <label htmlFor="exampleInputTitle1">Title</label>
                                        <input { ...postTitle } type="text" className="form-control" id="exampleInputTitle1" aria-describedby="emailHelp" />
                                    </div>
                                    <div className="form-group">
                                        <label htmlFor="exampleInputIdea">Write your feelings</label>
                                        <input { ...postIdea } type="text" className="form-control" id="exampleInputIdea" aria-describedby="emailHelp" />
                                    </div>
                                    <div className="form-group">
                                        <div className="custom-file">
                                            <input value='' onChange = { postImage.onChange } type="file"  className="custom-file-input" id="customFileLangHTML" />
                                            <label className="custom-file-label" htmlFor="customFileLangHTML" data-browse="Image">{ postImage.value.target.name }</label>
                                        </div>
                                    </div>
                                    <button type="submit" className="btn btn-primary m-2">Submit</button>
                                </form>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <Modal { ...Message } />
                <div className="row">
                    {
                        userPosts.map( post => (
                            <UserPost key={ post.id } { ...post } />
                        ) )
                    }
                </div>
            </div>
        </>
    );
}