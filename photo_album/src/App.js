import React from 'react';
import Header from './components/shared/header/Header';
import { Route, Switch } from 'react-router-dom';
import Home from './components/Home';
import Signup from './components/Signup';
import Settings from './components/Settings';
import Signin from './components/context/Signin';
import ProtectedComponent from './components/ProtectedComponent';
import MyInstagram from './components/MyInstagram';

function App() {

  return (
    <>
    <div className="container">
      <div className="row">
        <div className="col-12">
          <Header />
        </div>
      </div>
      <div className="row m-5">
        <Switch>
          <Route exact path="/">
            <Home />
          </Route>
          <Route path="/signup">
            <Signup />
          </Route>
          <Route path="/signin">
            <Signin />
          </Route>
          <Route path="/settings" >
            <Settings />
          </Route>
          <ProtectedComponent path="/myinstagram" component = { MyInstagram } />
        </Switch>
        </div>
    </div>
    </>
  );
}

export default App;
