$(function() {
  if (!$('#indices-new').length) {
    return;
  }

  $('.assets').DataTable();

  $('.pick').on('change', function(e) {
    var $this = $(this);
    var asset_data = $this.parents('tr').data();

    if ($this.get(0).checked) {
      var asset = new Asset(asset_data);
      assets.add_asset(asset);
    }
    else {
      var asset = assets.find_asset(asset_data.code);
      assets.remove_asset(asset);
    }
  });

  var assets = new Assets();

});

var Asset = function(options) {
  this.id = options.id;
  this.name = options.name;
  this.code = options.code;
}

var Assets = function() {
  this.assets = [];
};
Assets.prototype = {
  add_asset: function(asset) {
    this.assets.push(asset);
    this.render();
  },

  remove_asset: function(asset) {
    if (!asset) { return; }
    var index = this.assets.indexOf(asset);
    if (index < 0) { return; }

    this.assets.splice(index, 1);
    this.render();
  },

  find_asset: function(code) {
    return this.assets.filter(function(asset) { return asset.code === code })[0];
  },

  render: function() {
    console.log('render');
    console.log(this.assets);
  }
};
