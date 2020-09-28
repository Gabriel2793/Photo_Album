import { useState } from 'react';

export function InputImage( defaultValue ) {
    const [ value, setValue ] = useState( defaultValue );
    return (
        [
            { value, onChange: e => setValue( { 
                target: {
                    files:e.target.files[0],
                    name:e.target.files[0].name
                }
             } ) },
            () => setValue( defaultValue )
        ]
    );
};