var HaikuForm = React.createClass({
  getInitialState() {
      return {
          error:false
      };
  },
  handleSubmit: function(e) {
    // console.log(e);
    e.preventDefault();
  },

  shouldComponentUpdate(nextProps, nextState) {
    // console.log(nextState);
    var hasErrorChange = nextState.error !== this.state.error;
    var hasLineChanged = nextState.line !== this.state.line;
    return hasLineChanged || hasErrorChange;
  },

  haikuChanged: function(e) {
    
    this.setState({line: e.target.value});
    
    if (e.target.value === "test") {
      this.setState({error: true})
    } else {
      this.setState({error: false})
    }
  },

  _testFunc: function() {
    if (this.state.error) {
      return (<p>error</p>);
    } else {
      return "";
    }

  },

  render: function() {
    console.log('Rendering!!');
    return (
      <div>
      <h3>{this.state.line}</h3>

    <form className="haikuForm" onSubmit={this.handleSubmit}>
      <input type="text" placeholder="First Haiku Line" onChange={this.haikuChanged} />
      <input type="submit" value="Create Haiku!" />
      {this._testFunc()}
    </form>
    </div>
    );
  }

});
