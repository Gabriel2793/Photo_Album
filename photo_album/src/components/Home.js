import React from 'react';
import memories from '../assets/img/memories.jpg';

export default function Home() {

    return (
            <div>
                <div class="alert alert-primary text-center" role="alert">
                 <b>Save all your memories here</b>
                </div>
                <img src={memories} class="img-fluid" alt="Responsive image" />
            </div>
    );
}