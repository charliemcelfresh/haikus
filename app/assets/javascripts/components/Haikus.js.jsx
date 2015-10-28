var Haikus = React.createClass({
  render: function() {
    var haikuListing = this.props.data.map(function(haiku) {
      return (
        <li><Haiku id_number={haiku.id} /></li>
      );
    });
    return (
      <div>
        <h1>Haikus</h1>
        <ul>{ haikuListing }</ul>
      </div>
    );
  }
});
