$(document).on('turbolinks:load', function() {
  if (!$('#indices-new').length) {
    return;
  }

  $('.assets').DataTable();

  $(document).on('click', 'tr.asset', function(e) {
    var $this = $(this);
    var asset_data = $this.data();

    var asset = new Asset(asset_data);
    assets.add_asset(asset);
  });

  var assets = window.assets = new Assets($('.picked_assets'));
  var validator = window.validator = new FormValidator($('#new_index'));
});

var Asset = function(options) {
  this.id = options.id;
  this.name = options.name;
  this.code = options.code;
  this.weight = 1;

  this.view = new AssetView({ asset: this });
}

var AssetView = function(options) {
  this.asset = options.asset;
  this.el = this.$el = $('<div class="asset">');
}
AssetView.prototype = {
  remove_link: function() {
    var self = this;

    return $('<div class="remove"><a href="#">x</a></div>')
    .on('click', function(e) {
      e.preventDefault();
      assets.remove_asset(self.asset);
    });
  },

  weight_input: function() {
    var self = this;

    if (self.weight_input_el) {
      return self.weight_input_el;
    }

    self.weight_input_el = $('<input type="number" step="0.1">')
    .val(self.asset.weight)
    .on('change', function() {
      self.asset.weight = parseFloat($(this).val());
      if (self.form_data_el) {
        self.form_data_el.val(self.asset.weight);
      }
    });

    return self.weight_input();
  },

  form_data: function() {
    if (this.form_data_el) {
      return this.form_data_el;
    }

    this.form_data_el = $('<input type="hidden" name="index[codes][' + this.asset.code + ']">')
    .val(this.asset.weight);

    return this.form_data();
  },

  render: function() {
    var html = [
      '<div class="name">',
      this.asset.name,
      '(' + this.asset.code + ')',
      '</div>'
    ].join(' ');

    this.$el.html(html);
    this.$el.append(this.form_data());
    this.$el.append(this.weight_input());
    this.$el.append(this.remove_link());
    return this;
  }
};

var FormValidator = function(form) {
  this.form = form;
  this.form.on('submit', this.validate.bind(this));
  this.form.on('change', this.validate.bind(this));
  this.form.on('keyup', this.validate.bind(this));
  this.submit = this.form.find('#create_index').removeAttr('disabled');
  this.index_name = this.form.find('#index_name');

  this.validate();
}
FormValidator.prototype = {
  validate: function(e) {
    var valid = true;

    if (!this.index_name.val()) {
      valid = false;
    }

    if (!assets.any()) {
      valid = false;
    }

    if (valid) {
      this.submit.removeAttr('disabled');
    }
    else {
      this.submit.attr('disabled', 'disabled');

      if (e) {
        e.preventDefault();
      }
    }

    return valid;
  }
};

var Assets = function(container) {
  if (!container) {
    throw Error('No container specified');
  }

  this.assets = [];
  this.container = container;
};
Assets.prototype = {
  any: function() {
    return this.assets.length > 0;
  },

  add_asset: function(asset) {
    var existing_asset = this.find_asset(asset.code);
    if (existing_asset) { return; }

    this.assets.push(asset);
    this.render_asset(asset);

    validator.validate();
  },

  remove_asset: function(asset) {
    if (!asset) { return; }
    var index = this.assets.indexOf(asset);
    if (index < 0) { return; }

    this.assets.splice(index, 1);
    this.unrender_asset(asset);

    validator.validate();
  },

  find_asset: function(code) {
    return this.assets.filter(function(asset) { return asset.code === code })[0];
  },

  render_asset: function(asset) {
    this.container.append(asset.view.render().el);
  },

  unrender_asset: function(asset) {
    asset.view.$el.remove();
  },

  render: function() {
    var self = this;

    console.log('render');
    console.log(this.assets);

    this.container.html('');
    this.assets.forEach(self.render_asset);
  }
};