import { useState } from 'react';

export function Input( defaultValue ) {
    const [ value, setValue ] = useState( defaultValue );
    return (
        [
            { value, onChange: e => setValue( e.target.value ) },
            ( newValue ) => setValue( newValue )
        ]
    );
};